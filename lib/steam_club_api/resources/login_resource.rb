module SteamClubAPI
  class LoginResource < Resource
    attr_reader :user_auth_url, :username

    def initialize(username, password, options = {})
      super(options)
      @user_auth_url = options.fetch :user_auth_url, default_user_auth_url
      @rsa_key = options[:rsa_key]
      @username = remove_non_ascii(username)
      @password = remove_non_ascii(password)
      @auth_options = {}
    end

    def headers
      {
        'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'User-Agent' => user_agent,
        'Accept' => 'application/json, text/javascript;q=0.9, */*;q=0.5'
      }
    end

    def self.login(username, password, options = {})
      new(username, password, options).login(options)
    end

    def login(options = {})
      merge_auth_options(options)

      request(:post, request_options)
    end

    private

    attr_reader :password, :auth_options

    def merge_auth_options(options)
      @auth_options.merge!(options.slice(*allowed_auth_options))
    end

    def remove_non_ascii(text)
      text.gsub(/[^\x00-\x7F]/i, '')
    end

    def query
      {
        username: username,
        password: rsa_key.encrypt(password),
        rsatimestamp: rsa_key.timestamp,
        emailauth: '',
        loginfriendlyname: '',
        captchagid: '',
        captcha_text: '',
        remember_login: 'true'
      }.merge!(auth_options)
    end

    def allowed_auth_options
      [:captchagid, :captcha_text, :emailauth, :loginfriendlyname]
    end

    def request_options
      {
        headers: headers,
        resource_name: user_auth_url,
        body: query
      }
    end

    def rsa_key
      @rsa_key || SteamClubAPI::RSAKeyResource.get(username)
    end

    def default_user_auth_url
      "https://steamcommunity.com/login/dologin/"
    end
  end
end

