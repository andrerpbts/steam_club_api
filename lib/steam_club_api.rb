require 'steam_club_api/version'
require 'active_support/all'
require 'httparty'
require 'virtus'

module SteamClubAPI
  require_relative 'steam_club_api/resources/resource'
  require_relative 'steam_club_api/resources/player_resource'
  require_relative 'steam_club_api/resources/rsa_key_resource'

  module Entities
    require_relative 'steam_club_api/entities/player'
    require_relative 'steam_club_api/entities/rsa_key'
  end

  module Parsers
    require_relative 'steam_club_api/parsers/parser'
    require_relative 'steam_club_api/parsers/rsa_key_parser'
    require_relative 'steam_club_api/parsers/player_parser'
  end

end
