class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def index
    @pools = Pool.all
    @places = Place.all

    @pool_paths = []
    @pools.each do |pool|
      @pool_paths << {start_lat: pool.start_place.latitude, start_lng: pool.start_place.longitude, start_name: pool.start_place.name, 
      end_lat: pool.end_place.latitude, end_lng: pool.end_place.longitude, end_name: pool.end_place.name }
    end
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "관리자만 접근 가능합니다."
    end
  end
end
