module BeaverDrive::Files
  extend self

  def get_files(id, username, password)
    file_inf = BeaverDrive.new(session[:username], session[:pasword])
  end

  def get_provider(id, username, password)
    file_inf = BeaverDrive.new(session[:username], session[:pasword])
    info = file_inf.call(functionl: "getProviderInfo/")
    retunr info['name']

  end




end
