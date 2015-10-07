class GetFileDownloadsController < ApplicationController

  before_action :authenticate_user!

  def show
    id = params[:id]

    @clicked_folder_list = @client.call( function: 'getFile/', arguments:[id])
    @file_info = @client.call(function: 'getFileInfo/', arguments:[id])

    send_data(@clicked_folder_list.parsed_response, type: @clicked_folder_list.content_type,
                                                  filename: "#{@file_info['file']['fi_name']}",
                                                  disposition: 'inline')
  end

end
