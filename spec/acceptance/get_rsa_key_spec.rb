require 'spec_helper'

describe 'Get RSA key' do
  let(:rsa_key_resource) { SteamClubAPI::RSAKeyResource }
  let(:username) { 'killer' }
  let(:rsa_key_url) { 'http://www.rsakey.com/' }


  before do
    WebMock.stub_request(:post, /rsakey.com/)
  end

  it 'get RSA key by username' do
    rsa_key_resource.get username, rsa_key_url: rsa_key_url
    expect(WebMock).to have_requested(:post, rsa_key_url)
  end
end
