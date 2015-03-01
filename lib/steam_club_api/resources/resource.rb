module SteamClubAPI
  class Resource
    attr_reader :debug, :user_agent

    def initialize(options = {})
      @debug = options.fetch :debug, false
      @user_agent = options.fetch :user_agent, default_user_agent
    end

    def self.inherited(subclass)
      subclass.class_eval do |c|
        c.send :include, HTTParty
      end
    end

    protected

    def request(http_method, options={})
      path = options.fetch(:resource_name) { resource_name }
      options.merge!(debug_output: $stdout) if debug
      self.class.send(http_method, path, options)
    end

    def default_user_agent
      'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36'
    end
  end
end
