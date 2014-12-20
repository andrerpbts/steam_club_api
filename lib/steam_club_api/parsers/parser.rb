module SteamClubAPI
  module Parsers
    class Parser
      attr_reader :response, :entity

      def initialize(response, options = {})
        @response = response
        @entity = options.fetch :entity, default_entity
      end

      def self.parse(response)
        new(response).parse
      end

      private

      def parsed_response
        response.parsed_response || {}
      end
    end
  end
end
