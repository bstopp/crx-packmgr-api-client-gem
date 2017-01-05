require 'spec_helper'

# unit tests for init
# Metadata
# Display metadata about this package manager.
# @param [Hash] opts the optional parameters
# @return [InitData]
describe 'DefaultApi#init' do
  before do
    config = CrxPackageManager::Configuration.new
    @instance = CrxPackageManager::DefaultApi.new(CrxPackageManager::ApiClient.new(config))
  end

  let(:init_data) do
    data = <<-JSON
      {
        "contextPath": "/crx",
        "launchpadContextPath": "/",
        "jcrVersion": "2.0",
        "workspace": "crx.default",
        "userID": "Administrator",
        "workspaces": [
          "crx.default"
        ]
      }
    JSON
    data
  end

  it 'should work' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/init.jsp"
    ).to_return(status: 200, body: init_data, headers: { 'Content-Type' => 'application/json' })

    data = @instance.init
    expect(data).to be_a(CrxPackageManager::InitData)
    expect(data.context_path).to eq('/crx')
    expect(data.launchpad_context_path).to eq('/')
    expect(data.jcr_version).to eq('2.0')
    expect(data.workspace).to eq('crx.default')
    expect(data.user_id).to eq('Administrator')
    expect(data.workspaces).to eq(['crx.default'])
    expect(get_stub).to have_been_requested

  end

  it 'should support config changes' do
    WebMock.reset!
    @instance.api_client.config.configure do |c|
      c.scheme = 'https'
      c.host = 'notlocalhost'
      c.base_path = '/contextroot/crx/packgr'
    end
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/init.jsp"
    ).to_return(status: 200, body: init_data, headers: { 'Content-Type' => 'application/json' })

    data = @instance.init
    expect(data).to be_a(CrxPackageManager::InitData)
    expect(data.context_path).to eq('/crx')
    expect(data.launchpad_context_path).to eq('/')
    expect(data.jcr_version).to eq('2.0')
    expect(data.workspace).to eq('crx.default')
    expect(data.user_id).to eq('Administrator')
    expect(data.workspaces).to eq(['crx.default'])
    expect(get_stub).to have_been_requested

  end

  it 'should support failures' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/init.jsp"
    ).to_return(status: 401)

    begin
      @instance.init
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
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/init.jsp"
    ).with(query: {}
    ).to_return(status: 200, body: init_data, headers: { 'Content-Type' => 'application/json' })

    data = @instance.init(other_param: 'value')
    expect(data).to be_a(CrxPackageManager::InitData)
    expect(get_stub).to have_been_requested
  end

end