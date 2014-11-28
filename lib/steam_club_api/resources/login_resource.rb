module SteamClubAPI
  class LoginResource < Resource
    attr_reader :user_auth_url, :session_key, :query, :certificate_file

    def initialize(options = {})
      super
      @user_auth_url = options.fetch :user_auth_url, default_user_auth_url
      @certificate_file = options.fetch :certificate_file, default_certificate_file
      @session_key = OpenSSL::Random.random_bytes(32)
      @query = { sessionkey: crypted_session_key }
    end

    def headers
      {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
    end

    def self.login(steam_id64, password, options = {})
      new(options).login(steam_id64, password)
    end

    def login(steam_id64, password)
      query[:steamid] = steam_id64
      query[:encrypted_loginkey] = encrypt(password)
      request(:post, request_options)
    end

    private

    def encrypt(password)
      iv = OpenSSL::Random.random_bytes(16)
      aes = OpenSSL::Cipher::Cipher.new("AES-256-CBC")
      aes.encrypt
      aes.key = session_key
      aes.iv = iv if iv != nil
      (aes.update(password) + aes.final).unpack("H*")[0]
    end

    def crypted_session_key
      OpenSSL::PKey::RSA.new(certificate, session_key)
    end

    def certificate
      File.read certificate_file
    end

    def request_options
      {
        headers: headers,
        resource_name: user_auth_url,
        body: query
      }
    end

    def default_certificate_file
      File.expand_path('../../assets/cert.crt', __FILE__)
    end

    def default_user_auth_url
      "https://api.steampowered.com/ISteamUserAuth/AuthenticateUser/v1"
    end
  end
end

