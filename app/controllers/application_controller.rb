require 'beaver_storage'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :setup_connection

  def authenticate_user!
    redirect_to new_session_path, notice: 'Please sign in' unless user_signed_in?
  end

  def current_user
    @current_user ||= session[:username]
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def setup_connection
    if session[:username] && session[:password]
      @client = BeaverDrive::Client.new(
                                      uname: session[:username],
                                      password: session[:password]
                                      )
    end
  end

end
