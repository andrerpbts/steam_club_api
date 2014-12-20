module SteamClubAPI
  class RSAKeyResource < Resource
    attr_reader :parser, :rsa_key_url, :query

    def initialize(options = {})
      super
      @rsa_key_url = options.fetch(:rsa_key_url, default_rsa_key_url)
      @query = {}
    end

    def headers
      {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
    end

    def get(username)
      query[:username] = username
      request(:post, request_options)
    end

    def self.get(username, options = {})
      new(options).get(username)
    end

    private

    def request_options
      {
        headers: headers,
        resource_name: rsa_key_url,
        body: query
      }
    end

    def default_rsa_key_url
      "http://store.steampowered.com/login/getrsakey/"
    end

  end
end
