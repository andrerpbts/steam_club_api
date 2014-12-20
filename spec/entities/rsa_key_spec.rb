require 'spec_helper'

describe SteamClubAPI::Entities::RSAKey do
  let(:rsa_key) { build :rsa_key }
  subject { described_class.new(rsa_key.attributes) }

  it { expect(subject.steamid).to eq(rsa_key.steamid) }
  it { expect(subject.publickey_mod).to eq(rsa_key.publickey_mod) }
  it { expect(subject.publickey_exp).to eq(rsa_key.publickey_exp) }
  it { expect(subject.timestamp).to eq(rsa_key.timestamp) }
end
