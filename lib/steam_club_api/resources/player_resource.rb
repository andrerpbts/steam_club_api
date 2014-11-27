module SteamClubAPI
  class PlayerResource < Resource
    attr_reader :parser, :custom_url, :steam_id64_url

    def initialize(options = {})
      super
      @steam_id64_url = options.fetch :steam_id64_url, default_steam_id64_url
      @custom_url = options.fetch :custom_url, default_custom_url
      @parser = options.fetch :parser, default_parser
    end

    def self.search(query, options = {})
      type = case query
      when /^(?<num>\d+)$/
        :steam_id64
      else
        :custom
      end

      new(options).search(type, query)
    end

    def search(type, query)
      url = url_for(type)
      return false unless url

      parser.parse request(:get, resource_name: url.gsub('{{query}}', query))
    end

    private

    def url_for(type)
      type_url = "#{type}_url"
      send(type_url) if respond_to?(type_url)
    end

    def default_steam_id64_url
      "http://steamcommunity.com/profiles/{{query}}?xml=1"
    end

    def default_custom_url
      "http://steamcommunity.com/id/{{query}}?xml=1"
    end

    def default_parser
      SteamClubAPI::Parsers::PlayerParser
    end
  end
end
