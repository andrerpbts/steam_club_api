module SteamClubAPI
  module Entities
    class Session
      include Virtus.model

      attribute :publickey_mod, String

    end
  end
end
