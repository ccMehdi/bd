require 'base64'
require 'httparty'
require 'uri'
#require 'pry'

class BeaverDrive::Client

  attr_accessor :uname,
                :password,
                :token,
                :error,
                :result

  BASE_URI = 'http://sme.beaverdrive.com/api/json'

  def initialize(options = {})
    @uname        = options[:uname]
    @password     = options[:password]
  end

  def call(req)
    begin
      get_token
      perform_rpc(req)
    rescue => e
      raise e
    ensure
      destroy_token
    end
    result || false
  end


  private

  def get_token

    #encode username and password
    uname_encoded    = encode(uname)
    password_encoded  = encode(password)

    login_path = "/*/gettoken/#{uname_encoded},#{password_encoded}"
    login_url  = BASE_URI + login_path

    response = HTTParty.get(login_url)
    if response['status'] == 'ok'
      @token = response['token']
    else
      @errors = response['status'] || 'Please verify your login information!'
    end
  end

  def perform_rpc(req)

    http_method = req[:method] || 'get'
    function = req[:function]
    arguments = req[:arguments] || []

    arguments_encoded = encode_arguments(arguments)
    function_path = "/#{token}/#{function}/#{arguments_encoded}"
    url  = BASE_URI + function_path
    raw_response = HTTParty.send(http_method.to_sym, url)

    if raw_response.headers['content-type'] == 'application/json'
      @result = JSON.parse raw_response.body
    elsif raw_response.headers['content-type'] == 'application/octet-stream'
      @result = raw_response
    else
      @result = raw_response
    end
  end


  def destroy_token
    response = HTTParty.get(BASE_URI + "/#{token}/logout/")
    if response['status'] == 'ok'
      @token = nil
    end
  end

  def encode_arguments(a)
    a.map {|arg| Base64.encode64(arg).chomp }.join(",")
  end

  def encode(str)
    Base64.encode64(str).chomp
  end
end
