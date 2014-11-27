require 'spec_helper'

describe SteamClubAPI::PlayerResource do
  let(:parser) { double :parser, parse: :player }
  let(:options) do
    { parser: parser, url: 'http://www.steam.com/{{query}}' }
  end

  subject { described_class.new(options) }

  describe ".search" do
    subject { described_class }

    it "calls the search for username" do
      expect(subject).to receive_message_chain("new.search")
        .with(:username, 'KiLLeR', options) { :player }
      subject.search 'KiLLeR', options
    end

    it "calls the search for username" do
      expect(subject).to receive_message_chain("new.search")
        .with(:steam_id64, '123', options) { :player }
      subject.search '123', options
    end
  end

  describe "#search" do
    let(:query) { 'test' }
    let(:expected_url) { options[:url].gsub! '{{query}}', query }
    it "calls the parser for the request response" do
      expect(subject).to receive(:request).with(:get, resource_name: expected_url)
      expect(subject.parser).to receive(:parse)

      subject.search :username, query, options
    end

    it "returns false if passed non-recognized type" do
      expect(subject.search(:wtf, query, options)).to be_falsey
    end
  end
end
