module SteamClubAPI
  class Resource
    attr_reader :debug

    def initialize(options = {})
      @debug = options.fetch :debug, false
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
  end
end
