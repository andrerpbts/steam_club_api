module SteamClubAPI
  module Parsers
    class RSAKeyParser < Parser
      def parse
        entity.new rsa_key_params
      end

      def rsa_key_params
        parsed_response.symbolize_keys
      end

      private

      def default_entity
        SteamClubAPI::Entities::RSAKey
      end
    end
  end
end
