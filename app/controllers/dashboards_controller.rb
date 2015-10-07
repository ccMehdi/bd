class DashboardsController < ApplicationController

  before_action :authenticate_user!, only: [:index]

  def index


    @provider_info = @client.call(function: 'getProviderInformation/')
    user_info = @client.call(function: 'getUserInfo/')
    folder_list = @client.call(function: 'getProviders/')

    @user_detail_info = user_info['userinfo']
    session[:user_info] = @user_detail_info['us_name']

    @user_option_info = @user_detail_info['us_options']
    folder_list_details = folder_list['used']

    @folder_list_details = Kaminari.paginate_array(folder_list_details).page(params[:page]).per(2)

    @user_info = UserInfo.new(
                              us_name: @user_detail_info['us_name'],
                              us_adress: @user_detail_info['us_adress'],
                              us_phone: @user_detail_info['us_phone']
                              )
  end

end
