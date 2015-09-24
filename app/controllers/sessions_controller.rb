require "beaver_storage"

class SessionsController < ApplicationController

  attr_accessor :username, :password

  def create

    @token = BeaverStorage::Api.get_token(params[:username], params[:password])
    if @token
      session[:username] = params[:username]
      session[:password] = params[:password]

      redirect_to users_path

    end
  end

end
