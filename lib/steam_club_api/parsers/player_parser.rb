module SteamClubAPI
  module Parsers
    class PlayerParser
      attr_reader :response, :entity

      def initialize(response, options = {})
        @response = response
        @entity = options.fetch :entity, default_entity
      end

      def parse
        entity.new player_params
      end

      def self.parse(response)
        new(response).parse
      end

      def player_params
        Hash[profile.map { |key, value| [key.underscore.downcase.to_sym, value] }]
      end

      private

      def default_entity
        SteamClubAPI::Entities::Player
      end

      def profile
        parsed_response.symbolize_keys.fetch :profile, {}
      end

      def parsed_response
        response.parsed_response || {}
      end
    end
  end
end
