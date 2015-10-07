
class SessionsController < ApplicationController

  def new
  end

  def create
    @token = BeaverDrive::Client.new(
                                    uname: params[:username],
                                    password: params[:password],
                                    function: 'gettoken/'
                                    )

    if @token
      session[:username]  = params[:username]
      session[:password]  = params[:password]
      redirect_to dashboards_path
    end
  end

  def destroy
    session[:username] = nil
    session[:password] = nil
    redirect_to new_session_path, notice: 'Sign out successfully!'
  end

end
