require 'spec_helper'

describe SteamClubAPI::PlayerResource do
  let(:parser) { double :parser, parse: :player }
  let(:options) do
    {
      parser: parser,
      custom_url: 'http://www.steam.com/{{query}}',
      steam_id64_url: 'http://www.steam.com/{{query}}'
    }
  end

  subject { described_class.new(options) }

  describe ".search" do
    subject { described_class }

    it "calls the search for custom" do
      expect(subject).to receive_message_chain("new.search")
        .with(:custom, 'KiLLeR') { :player }
      subject.search 'KiLLeR', options
    end

    it "calls the search for steam_id64" do
      expect(subject).to receive_message_chain("new.search")
        .with(:steam_id64, '123') { :player }
      subject.search '123', options
    end
  end

  describe "#search" do
    let(:query) { 'test' }
    let(:expected_url) { options[:custom_url].gsub! '{{query}}', query }
    it "calls the parser for the request response" do
      expect(subject).to receive(:request).with(:get, resource_name: expected_url)
      expect(subject.parser).to receive(:parse)

      subject.search :custom, query
    end

    it "returns false if passed non-recognized type" do
      expect(subject.search(:wtf, query)).to be_falsey
    end
  end
end
