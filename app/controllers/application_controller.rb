class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def index
    @pools = Pool.all
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
