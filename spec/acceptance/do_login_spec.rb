require 'spec_helper'

describe 'Do Login' do
  let(:login_resource) { SteamClubAPI::LoginResource }
  let(:username) { 'killer' }
  let(:password) { 'ikill01' }
  let(:captchagid) { '12345' }
  let(:captcha_text) { 'A312B' }
  let(:emailauth) { 'D3KRT' }
  let(:loginfriendlyname) { 'userpc1' }
  let(:user_auth_url) { 'http://www.dologin.com/' }
  let(:rsa_key) { double :rsa_key, encrypt: '1', timestamp: Time.current.to_i }
  let(:options) do
    {
      user_auth_url: user_auth_url,
      rsa_key: rsa_key,
      captchagid: captchagid,
      captcha_text: captcha_text,
      emailauth: emailauth,
      loginfriendlyname: loginfriendlyname,
      user_agent: 'bot'
    }
  end

  let(:expected_body) do
    "username=#{username}&password=#{rsa_key.encrypt}&rsatimestamp=#{rsa_key.timestamp}&"     +
    "emailauth=#{emailauth}&loginfriendlyname=#{loginfriendlyname}&captchagid=#{captchagid}&" +
    "captcha_text=#{captcha_text}&remember_login=true"
  end

  let(:expeted_headers) do
    {
      'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8',
      'User-Agent' => 'bot',
      'Accept' => 'application/json, text/javascript;q=0.9, */*;q=0.5'
    }
  end

  before do
    WebMock.stub_request(:post, /dologin.com/)
  end

  it 'log in steam user' do
    login_resource.login username, password, options
    expect(WebMock).to have_requested(:post, user_auth_url)
      .with(body: expected_body, headers: expeted_headers)
  end
end
