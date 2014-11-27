module SteamClubAPI
  class LoginResource < Resource
    attr_reader :user_auth_url

    def initialize(options = {})
      super
      @user_auth_url = options.fetch :user_auth_url, default_user_auth_url
    end

    def self.login(options = {})
      new(options).login
    end

    def login
      request(:post, resource_name: user_auth_url)
    end

    private

    def default_user_auth_url
      "https://api.steampowered.com/ISteamUserAuth/AuthenticateUser/v1"
    end
  end
end

