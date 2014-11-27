require 'spec_helper'

describe 'Get player' do
  let(:player_resource) { SteamClubAPI::PlayerResource }
  let(:custom) { 'player' }
  let(:steamid) { '123' }
  let(:custom_url) { 'http://www.custom.com/{{query}}' }
  let(:steamid_url) { 'http://www.steamid.com/{{query}}' }

  before do
    WebMock.stub_request(:get, /custom.com/)
    WebMock.stub_request(:get, /steamid.com/)
  end

  it 'get player by custom' do
    player_resource.search custom, custom_url: custom_url
    expect(WebMock).to have_requested(:get, custom_url.gsub('{{query}}', custom))
  end

  it 'get player by stemaid' do
    player_resource.search steamid, steam_id64_url: steamid_url
    expect(WebMock).to have_requested(:get, steamid_url.gsub('{{query}}', steamid))
  end
end
