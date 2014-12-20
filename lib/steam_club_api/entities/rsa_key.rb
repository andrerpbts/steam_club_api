module SteamClubAPI
  module Entities
    class RSAKey
      include Virtus.model

      attribute :publickey_mod, String
      attribute :publickey_exp, String
      attribute :timestamp, Integer
      attribute :steamid, String
    end
  end
end
