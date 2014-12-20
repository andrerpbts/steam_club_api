FactoryGirl.define do
  factory :rsa_key, class: SteamClubAPI::Entities::RSAKey do
    steamid 76561198071043585
    publickey_mod 'AEA0'
    publickey_exp '100'
    timestamp { Time.current.to_i }
  end
end
