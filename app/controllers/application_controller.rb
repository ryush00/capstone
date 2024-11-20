class ApplicationController < ActionController::Base
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
end
