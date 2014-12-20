require 'spec_helper'

describe SteamClubAPI::Parsers::RSAKeyParser do
  let(:timestamp) { Time.current.to_i }
  let(:profile) do
    {
      'publickey_mod' => 'AEA0',
      'publickey_exp' => '100',
      'timestamp' => timestamp,
      'steamid' => '1999'
    }
  end

  let(:response) { double :response, parsed_response: profile }
  subject { described_class.new(response) }

  describe "#parse" do
    let(:rsa_key) { subject.parse }

    it { expect(rsa_key).to be_kind_of(subject.entity) }
    it { expect(rsa_key.publickey_mod).to eq('AEA0') }
  end

  describe ".parse" do
    subject { described_class }

    it "create a new instance and call #parse method" do
      expect(subject).to receive_message_chain("new.parse") { :rsa_key }
      subject.parse(response)
    end
  end

  describe "#rsa_key_params" do
    let(:expected_params) do
      {
        publickey_mod: 'AEA0',
        publickey_exp: '100',
        timestamp: timestamp,
        steamid: '1999'
      }
    end
    it { expect(subject.rsa_key_params).to eq(expected_params) }
  end
end
