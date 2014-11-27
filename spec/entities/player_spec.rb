require 'spec_helper'

describe SteamClubAPI::Entities::Player do
  let(:player) { build :player }
  let(:steam_id32) { 110777857 }
  subject { described_class.new(player.attributes) }

  it { expect(subject.steam_id64).to eq(player.steam_id64) }
  it { expect(subject.steam_id).to eq(player.steam_id) }
  it { expect(subject.custom_url).to eq(player.custom_url) }
  it { expect(subject.privacy_state).to eq(player.privacy_state) }
  it { expect(subject.visibility_state).to eq(player.visibility_state) }
  it { expect(subject.avatar_icon).to eq(player.avatar_icon) }
  it { expect(subject.avatar_medium).to eq(player.avatar_medium) }
  it { expect(subject.avatar_full).to eq(player.avatar_full) }
  it { expect(subject.member_since).to eq(player.member_since) }
  it { expect(subject.location).to eq(player.location) }
  it { expect(subject.realname).to eq(player.realname) }
  it { expect(subject.summary).to eq(player.summary) }
  it { expect(subject.vac_banned).to eq(player.vac_banned) }
  it { expect(subject.trade_ban_state).to eq(player.trade_ban_state) }
  it { expect(subject.is_limited_account).to eq(player.is_limited_account) }

  describe "#steam_id32" do
    it { expect(subject.steam_id32).to eq(steam_id32) }
  end

  describe "#steam_id32_tag" do
    it { expect(subject.steam_id32_tag).to eq("STEAM_1:1:#{steam_id32}") }
  end

  describe "#public?" do
    it { expect(subject.public?).to be_truthy }

    it "privacy_state is private" do
      subject.privacy_state = 'private'
      expect(subject.public?).to be_falsey
    end
  end

  describe "#private?" do
    it { expect(subject.private?).to be_falsey }

    it "privacy_state is private" do
      subject.privacy_state = 'private'
      expect(subject.private?).to be_truthy
    end
  end

  describe "#privacy" do
    it { expect(subject.privacy).to eq(1) }

    it "privacy_state is private" do
      subject.privacy_state = 'private'
      expect(subject.privacy).to eq(0)
    end
  end

  describe "#vac_banned?" do
    it { expect(subject.vac_banned?).to be_falsey }

    it "vac_banned equal 1" do
      subject.vac_banned = 1
      expect(subject.vac_banned?).to be_truthy
    end
  end

  describe "#limited_account?" do
    it { expect(subject.limited_account?).to be_falsey }

    it "limited_account equal 1" do
      subject.is_limited_account = 1
      expect(subject.limited_account?).to be_truthy
    end
  end
end
