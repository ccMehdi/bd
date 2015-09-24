require "net/http"
require "uri"
require "base64"

module BeaverStorage

  HTTP = Net::HTTP.new("sme.beaverdrive.com", 80)
  API_URI = "/api/json"
  USER_AGENT = "SMEStorage Automator Upload Workflow"
  # The interface to the REST api. You need a token to interact with it.
  #
  #   @token = BeaverStorage::Api.get_token(username, password)
  #
  # When you have the token, you can call any action you want in the API.
  #
  #   SmeStorage::Api.get(@token, "doInitUpload", "arbitary", "parameters", "here")
  class Api

    def self.get(*args)
      args[0] = @token if @token.present?
      instance = new(*args)
      instance.fetch
      instance.parse
      # instance
    end

    # Returns the token if successful, false if not.
    def self.get_token(username, password)
      response = get(nil, "gettoken", username, password)
      @token = response["token"]
    end

    def initialize(token, action, *arguments)
      @token = token || "*"
      @action = action
      @arguments = encode_arguments(arguments)
      @uri = [API_URI, @token, @action, @arguments].join("/")
    end

    def fetch
      request = Net::HTTP::Get.new(@uri)
      request["User-Agent"] = USER_AGENT
      @json = HTTP.request(request).body
    end

    def parse
      @doc = JSON.parse(@json)
    end

    private

    def encode_arguments(arguments)
      arguments.map {|arg| Base64.encode64(arg).chomp }.join(",")
    end
  end
end
