class GetFileProvidersController < ApplicationController

  before_action :authenticate_user!, only: [:index]

  def index
    @folder_list = @client.call(function: 'getFilesList/')
  end


end
