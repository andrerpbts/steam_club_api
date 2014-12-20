module SteamClubAPI
  module Parsers
    class PlayerParser < Parser
      def parse
        entity.new player_params
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
    end
  end
end
