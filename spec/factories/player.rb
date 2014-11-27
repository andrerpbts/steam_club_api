FactoryGirl.define do
  factory :player, class: SteamClubAPI::Entities::Player do
    steam_id64 76561198071043585
    steam_id 'KiLLeR'
    custom_url 'killer'
    privacy_state 'public'
    visibility_state '3'
    avatar_icon 'http://www.steam.com/1.png'
    avatar_medium 'http://www.steam.com/2.png'
    avatar_full 'http://www.steam.com/3.png'
    member_since { 2.days.ago }
    location 'Brazil'
    realname 'Alvaro Pereira'
    summary 'Nothing'
    vac_banned 0
    trade_ban_state 'None'
    is_limited_account 0
  end
end
