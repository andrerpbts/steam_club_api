require 'spec_helper'

describe SteamClubAPI::Entities::RSAKey do
  let(:rsa_key) { build :rsa_key }
  let(:expected_rsa_key) { read_fixture('key.pem') }
  let(:password) { 'supersecret' }
  subject { described_class.new(rsa_key.attributes) }

  it { expect(subject.steamid).to eq(rsa_key.steamid) }
  it { expect(subject.publickey_mod).to eq(rsa_key.publickey_mod) }
  it { expect(subject.publickey_exp).to eq(rsa_key.publickey_exp) }
  it { expect(subject.timestamp).to eq(rsa_key.timestamp) }

  it { expect(subject.rsa).to be_a(OpenSSL::PKey::RSA) }
  it { expect(subject.rsa.to_s).to eq(expected_rsa_key) }

  it { expect(subject.encrypt(password).size).to eq(344) }
end
