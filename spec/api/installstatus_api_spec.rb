require 'spec_helper'

# unit tests for init
# Metadata
# Display metadata about this package manager.
# @param [Hash] opts the optional parameters
# @return [InitData]
describe 'DefaultApi#installstatus' do
  before do
    config = CrxPackageManager::Configuration.new
    @instance = CrxPackageManager::DefaultApi.new(CrxPackageManager::ApiClient.new(config))
  end

  let(:status) do
    data = <<-JSON
      {
        "status": {
          "finished": true,
          "itemCount": 0
        }
      }
    JSON
    data
  end
  it 'should work' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/installstatus.jsp"
    ).to_return(status: 200, body: status, headers: { 'Content-Type' => 'application/json' })

    data = @instance.installstatus
    expect(data).to be_a(CrxPackageManager::InstallStatus)
    expect(data.status.finished).to eq(true)
    expect(data.status.item_count).to eq(0)
    expect(get_stub).to have_been_requested

  end

  it 'should support config changes' do
    WebMock.reset!
    @instance.api_client.config.configure do |c|
      c.scheme = 'https'
      c.host = 'notlocalhost'
      c.base_path = '/contextroot/crx/packgr'
      c.debugging = true
    end
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/installstatus.jsp"
    ).to_return(status: 200, body: status, headers: { 'Content-Type' => 'application/json' })

    data = @instance.installstatus
    expect(data).to be_a(CrxPackageManager::InstallStatus)
    expect(data.status.finished).to eq(true)
    expect(data.status.item_count).to eq(0)
    expect(get_stub).to have_been_requested

  end

  it 'should support failures' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/installstatus.jsp"
    ).to_return(status: 401)

    begin
      @instance.installstatus
    rescue CrxPackageManager::ApiError => e
      expect(e).not_to be_nil
      expect(e.code).to eq(401)
    end

    expect(get_stub).to have_been_requested
  end

  it 'should ignore params' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/installstatus.jsp"
    ).with(query: {}
    ).to_return(status: 200, body: status, headers: { 'Content-Type' => 'application/json' })

    data = @instance.installstatus(other_param: 'value')
    expect(data).to be_a(CrxPackageManager::InstallStatus)
    expect(get_stub).to have_been_requested
  end

end