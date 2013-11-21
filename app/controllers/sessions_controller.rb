class SessionsController < ApplicationController
  skip_before_filter :authorize_user
  skip_before_filter :verify_authenticity_token

  def create
    if auth_hash
      email = auth_hash.info.email
      name = auth_hash.info.name
      if user = User.find_by_email(email)
        sign_in user
        redirect_to root_path
        flash[:notice] = 'Logged in'
      else
        user = User.create!(email: email, name: name)
        sign_in user
        redirect_to new_player_path
        flash[:notice] = 'Logged in. Please create your player.'
      end
    else
      redirect_to google_failure_url
    end
  end

  def login
  end

  def logout
    sign_out
    redirect_to root_path
    flash[:notice] = 'Logged out'
  end

  def failure
    flash['error'] = 'Error while signing in to google account'
    redirect_to root_path
  end

  private

  def sign_in user
    reset_session
    session[:user_id] = user.id
    @current_user = user
  end

  def sign_out
    reset_session
    session[:user_id] = nil
    @current_user = nil
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def google_failure_url
    callback_url = "#{request.protocol}#{request.host_with_port}/login"
    "https://accounts.google.com/Logout?continue=https://appengine.google.com/_ah/logout?continue=#{callback_url}"
  end
end
