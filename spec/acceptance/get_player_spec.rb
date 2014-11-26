require 'spec_helper'

describe 'Get player' do
  let(:player_resource) { SteamClubAPI::PlayerResource }
  let(:username) { 'player' }
  let(:steamid) { '123' }
  let(:username_url) { 'http://www.username.com/{{query}}' }
  let(:steamid_url) { 'http://www.steamid.com/{{query}}' }

  before do
    WebMock.stub_request(:get, /username.com/)
    WebMock.stub_request(:get, /steamid.com/)
  end

  it 'get player by username' do
    player_resource.search username, url: username_url
    expect(WebMock).to have_requested(:get, username_url.gsub('{{query}}', username))
  end

  it 'get player by stemaid' do
    player_resource.search steamid, url: steamid_url
    expect(WebMock).to have_requested(:get, steamid_url.gsub('{{query}}', steamid))
  end
end
