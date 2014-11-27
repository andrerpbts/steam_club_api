module SteamClubAPI
  class PlayerResource < Resource
    attr_reader :parser

    URLS = {
      custom_url: "http://steamcommunity.com/id/{{query}}?xml=1",
      steam_id64: "http://steamcommunity.com/profiles/{{query}}?xml=1"
    }

    def initialize(options = {})
      super
      @parser = options.fetch :parser, default_parser
    end

    def self.search(query, options = {})
      type = case query
      when /^(?<num>\d+)$/
        :steam_id64
      else
        :custom_url
      end

      new.search(type, query, options)
    end

    def search(type, query, options)
      return false unless urls.include?(type)

      url = options.fetch :url, urls[type]
      parser.parse request(:get, resource_name: url.gsub('{{query}}', query))
    end

    private

    def default_parser
      SteamClubAPI::Parsers::PlayerParser
    end

    def urls
      URLS
    end
  end
end
