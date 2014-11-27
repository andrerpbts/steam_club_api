require 'spec_helper'

describe SteamClubAPI::Parsers::PlayerParser do
  let(:profile) do
    { 'profile' => { 'steamID64' => '123', 'steamID' => 'KiLLeR' } }
  end

  let(:response) { double :response, parsed_response: profile }
  subject { described_class.new(response) }

  describe "#parse" do
    let(:player) { subject.parse }

    it { expect(player).to be_kind_of(subject.entity) }
    it { expect(player.steam_id64).to eq(123) }
  end

  describe ".parse" do
    subject { described_class }

    it "create a new instance and call #parse method" do
      expect(subject).to receive_message_chain("new.parse") { :player }
      subject.parse(response)
    end
  end

  describe "#player_params" do
    let(:expected_params) do
      { steam_id64: '123', steam_id: 'KiLLeR' }
    end
    it { expect(subject.player_params).to eq(expected_params) }
  end


end
