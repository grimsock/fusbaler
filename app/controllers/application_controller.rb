class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authorize_user

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def authorize_user
    redirect_to login_path unless session[:user_id].present?
  end

  private

  def record_not_found
    render text: "Not Found", status: 404
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  helper_method :current_user
end
