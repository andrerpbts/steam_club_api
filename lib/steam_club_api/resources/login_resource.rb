module SteamClubAPI
  class LoginResource < Resource
    attr_reader :user_auth_url, :query

    def initialize(options = {})
      super
      @user_auth_url = options.fetch :user_auth_url, default_user_auth_url
      @query = default_query
    end

    def headers
      {
        'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'User-Agent' => 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36',
        'Accept' => 'application/json, text/javascript;q=0.9, */*;q=0.5'
      }
    end

    def self.login(username, password, auth_options = {}, options = {})
      new(options).login(username, password, auth_options)
    end

    def login(username, password, auth_options = {})
      query[:username] = remove_non_ascii(username)
      query[:password] = rsa_key.encrypt(remove_non_ascii(password))
      query[:rsatimestamp] = rsa_key.timestamp

      auth_options.slice!(*allowed_auth_options)
      query.merge!(auth_options)

      request(:post, request_options)
    end

    private

    def remove_non_ascii(text)
      text.gsub(/[^\x00-\x7F]/i, '')
    end

    def default_query
      {
        emailauth: '',
        loginfriendlyname: '',
        captchagid: '',
        captcha_text: '',
        emailsteamid: '',
        rsatimestamp: '',
        remember_login: 'true'
      }
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
      @rsa_key ||= SteamClubAPI::RSAKeyResource.get(query[:username])
    end

    def default_user_auth_url
      "https://steamcommunity.com/login/dologin/"
    end
  end
end

