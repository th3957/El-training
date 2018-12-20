module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def login_request
    redirect_to root_path unless logged_in?
  end

  def authorization_check
    redirect_to root_path, alert: 'Permission denied.' unless current_user.role == 'role_admin'

  end
end
