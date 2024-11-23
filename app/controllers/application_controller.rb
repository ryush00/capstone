class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def index
    @pools = Pool.all
    @places = Place.all

    @my_pools = Pool.joins(:bookings)
      .where(bookings: { user_id: current_user.id })
      .where('pools.end_at >= ? AND pools.end_at <= ?', Time.current, 1.day.from_now)

    @pool_paths = []
    @pools.each do |pool|
      @pool_paths << {
        start_id: pool.start_place.id, start_lat: pool.start_place.latitude, start_lng: pool.start_place.longitude, start_name: pool.start_place.name,
        end_id: pool.end_place.id, end_lat: pool.end_place.latitude, end_lng: pool.end_place.longitude, end_name: pool.end_place.name,
        url: pool_path(pool)
      }
    end

    # 출발지 필터링
    if params[:start_place_id].present?
      @pools = @pools.where(start_place_id: params[:start_place_id])
    end

    # 도착지 필터링
    if params[:end_place_id].present?
      @pools = @pools.where(end_place_id: params[:end_place_id])
    end
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "관리자만 접근 가능합니다."
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [ :account_number, :account_bank, :account_name ])
  end
end
