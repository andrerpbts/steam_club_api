require 'steam_club_api/version'
require 'active_support/all'
require 'httparty'
require 'virtus'

module SteamClubAPI
  require_relative 'steam_club_api/resources/resource'
  require_relative 'steam_club_api/resources/login_resource'
  require_relative 'steam_club_api/resources/player_resource'

  module Entities
    require_relative 'steam_club_api/entities/player'
  end

  module Parsers
    require_relative 'steam_club_api/parsers/player_parser'
  end

end
