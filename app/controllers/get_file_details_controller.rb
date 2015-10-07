class GetFileDetailsController < ApplicationController

  before_action :authenticate_user!
  
  def show

    id = params[:id]
    @folder_list = @client.call(function: 'getFilesList/')
    @clicked_folder_list = @client.call(
                                      function: 'getFolderContents/',
                                      arguments:[id]
                                      )

    file_list_return =  @clicked_folder_list['filelist']
    @file_list_return = Kaminari.paginate_array(file_list_return).page(params[:page]).per(10)
    breadcrumb = @clicked_folder_list['parents']

    @breadcrumb_nav = []
    breadcrumb.each do |x|
      @breadcrumb_nav << {
                          'fi_id' => x['fi_id'],
                          'fi_pid' => x['fi_pid'],
                          'fi_name' => x['fi_name']
                          }
    end

  end

  def rename
    @id = params['fi_id']
    name = params['fi_name']

    @rename_folder = @client.call(
      function: 'dorenameFolder/', arguments:[@id, name]
    )
    respond_to do |format|
      if @rename_folder['status'] == 'ok'
        format.js { render "/get_file_details/rename/update_rename_success" }
      else
        format.js  { render "/get_file_details/rename/update_rename_error" } # don't do msg.to_json
      end
    end
  end

  def create_folder
    @fi_pid = params['fi_id']
    folder_name = params['fi_name']

    @create_folder = @client.call(
      function: 'doCreatenewfolder/', arguments:[folder_name, '', @fi_pid, '','','y']
    )

    respond_to do |format|
      if @create_folder['status'] == 'ok'
        format.js { render "/get_file_details/new_folder/update_new_folder_success" }
      else
        format.js  { render "/get_file_details/new_folder/update_new_folder_error" } # don't do msg.to_json
      end
    end
  end

end
