require 'spec_helper'

describe SteamClubAPI::RSAKeyResource do
  let(:parser) { double :parser, parse: :rsa_key }
  let(:options) do
    {
      parser: parser,
      rsa_key_url: 'http://www.steam.com/'
    }
  end
  let(:headers) do
    {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
  end

  let(:username) { 'killer' }

  subject { described_class.new(options) }

  describe ".get" do
    subject { described_class }

    it "calls the get method with the username" do
      expect(subject).to receive_message_chain("new.get")
        .with(username) { :rsa_key }
      subject.get username, options
    end
  end

  describe "#get" do
    let(:request_options) do
      {
        resource_name: options[:rsa_key_url],
        body: { username: username },
        headers: headers
      }
    end

    it "calls the parser for the request response" do
      expect(subject).to receive(:request).with(:post, request_options)
      expect(subject.parser).to receive(:parse)

      subject.get username
    end
  end
end
