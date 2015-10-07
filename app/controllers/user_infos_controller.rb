class UserInfosController < ApplicationController

  before_action :authenticate_user!

  def update
    user_info = UserInfo.new(params['user_info'])
    if user_info.valid?
      @update_user_info = @client.call(
          function: 'updateUsersData/',
          arguments:[
                    user_info.us_name,
                    user_info.us_adress,
                    user_info.us_phone
                    ]
      )

      respond_to do |format|
        if @update_user_info['status'] == 'ok'
          format.js { render "/dashboards/personal_info/update_personal_success" }
        else
          format.js  { render "/dashboards/personal_info/update_personal_error" } # don't do msg.to_json
        end
      end
    else
      respond_to do |format|
        format.js  { render "/dashboards/personal_info/update_personal_error" } # don't do msg.to_json
      end
    end
  end

end
