module SteamClubAPI
  module Entities
    class Player
      include Virtus.model

      attribute :steam_id64, Integer
      attribute :steam_id, String
      attribute :custom_url, String
      attribute :privacy_state, String
      attribute :visibility_state, String
      attribute :avatar_icon, String
      attribute :avatar_medium, String
      attribute :avatar_full, String
      attribute :member_since, Date
      attribute :location, String
      attribute :realname, String
      attribute :summary, String
      attribute :vac_banned, Integer
      attribute :trade_ban_state, String
      attribute :is_limited_account, Integer

      def steam_id32
        steam_id64 - 76561197960265728
      end

      def steam_id32_tag
        "STEAM_#{privacy}:#{steam_id64 % 2}:#{steam_id32}"
      end

      def public?
        privacy_state == 'public'
      end

      def private?
        !public?
      end

      def privacy
        public? && 1 || 0
      end

      def vac_banned?
        vac_banned == 1
      end

      def limited_account?
        is_limited_account == 1
      end
    end
  end
end
