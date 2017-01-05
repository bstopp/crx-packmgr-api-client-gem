require 'spec_helper'

# unit tests for groups
# List package groups
# Returns a list of all package groups available.
# @param [Hash] opts the optional parameters
# @option opts [String] :compress_version Compress versions; count all versions of the same packages as a single entry.
# @option opts [BOOLEAN] :include_all Return a total count of all packages. Default to false.
# @option opts [BOOLEAN] :include_root Include the root package. Defaults to false.
# @option opts [BOOLEAN] :include_my_packages Include the &#39;my_packages&#39; group. Only applicable if the group has no packages. Default to false.
# @option opts [BOOLEAN] :only_top_level Only list top-level groups, ie. do not list all nested groups.
# @return [GroupList]
describe 'DefaultApi#groups' do
  before do
    config = CrxPackageManager::Configuration.new
    @instance = CrxPackageManager::DefaultApi.new(CrxPackageManager::ApiClient.new(config))
  end

  let(:groups) do
    data = <<-JSON
      {
        "groups" : [
          {
            "name": "Adobe",
            "title": "Adobe",
            "count": 0,
            "deepCount": 1
          },
          {
            "name": "Adobe/granite",
            "title": "Adobe/granite",
            "count": 1,
            "deepCount": 1
          },
          {
            "name": "my_packages",
            "title": "my_packages",
            "count": 3,
            "deepCount": 3
          }
        ]
      }
    JSON
    data
  end

  it 'should work' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/groups.jsp"
    ).to_return(status: 200, body: groups, headers: { 'Content-Type' => 'application/json' })

    data = @instance.groups
    expect(data).to be_a(CrxPackageManager::GroupList)
    expect(data.groups).not_to be_nil
    expect(data.groups.length).to eq(3)
    expect(data.groups[0].name).to eq('Adobe')
    expect(data.groups[0].title).to eq('Adobe')
    expect(data.groups[0].count).to eq(0)
    expect(data.groups[0].deep_count).to eq(1)

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
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/groups.jsp"
    ).to_return(status: 200, body: groups, headers: { 'Content-Type' => 'application/json' })

    data = @instance.groups
    expect(data).to be_a(CrxPackageManager::GroupList)
    expect(data.groups).not_to be_nil
    expect(data.groups.length).to eq(3)
    expect(data.groups[0].name).to eq('Adobe')
    expect(data.groups[0].title).to eq('Adobe')
    expect(data.groups[0].count).to eq(0)
    expect(data.groups[0].deep_count).to eq(1)

    expect(get_stub).to have_been_requested
  end

  it 'should support failures' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/groups.jsp"
    ).to_return(status: 500)

    begin
      @instance.groups
    rescue CrxPackageManager::ApiError => e
      expect(e).not_to be_nil
      expect(e.code).to eq(500)
    end

    expect(get_stub).to have_been_requested
  end

  it 'should support compressVersion' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/groups.jsp"
    ).with(query: { compressVersion: true }
    ).to_return(status: 200, body: groups, headers: { 'Content-Type' => 'application/json' })

    data = @instance.groups(compress_version: true)
    expect(data).to be_a(CrxPackageManager::GroupList)
    expect(data.groups).not_to be_nil
    expect(get_stub).to have_been_requested
  end

  it 'should support includeAll' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/groups.jsp"
    ).with(query: { includeAll: true }
    ).to_return(status: 200, body: groups, headers: { 'Content-Type' => 'application/json' })

    data = @instance.groups(include_all: true)
    expect(data).to be_a(CrxPackageManager::GroupList)
    expect(data.groups).not_to be_nil
    expect(get_stub).to have_been_requested
  end

  it 'should support includeRoot' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/groups.jsp"
    ).with(query: { includeRoot: true }
    ).to_return(status: 200, body: groups, headers: { 'Content-Type' => 'application/json' })

    data = @instance.groups(include_root: true)
    expect(data).to be_a(CrxPackageManager::GroupList)
    expect(data.groups).not_to be_nil
    expect(get_stub).to have_been_requested
  end

  it 'should support includeMyPackages' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/groups.jsp"
    ).with(query: { includeMyPackages: true }
    ).to_return(status: 200, body: groups, headers: { 'Content-Type' => 'application/json' })

    data = @instance.groups(include_my_packages: true)
    expect(data).to be_a(CrxPackageManager::GroupList)
    expect(data.groups).not_to be_nil
    expect(get_stub).to have_been_requested
  end

  it 'should support onlyTopLevel' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/groups.jsp"
    ).with(query: { onlyTopLevel: true }
    ).to_return(status: 200, body: groups, headers: { 'Content-Type' => 'application/json' })

    data = @instance.groups(only_top_level: true)
    expect(data).to be_a(CrxPackageManager::GroupList)
    expect(data.groups).not_to be_nil
    expect(get_stub).to have_been_requested
  end

  it 'should ignore other params' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/groups.jsp"
    ).with(query: {}
    ).to_return(status: 200, body: groups, headers: { 'Content-Type' => 'application/json' })

    data = @instance.groups(other_param: 'value')
    expect(data).to be_a(CrxPackageManager::GroupList)
    expect(data.groups).not_to be_nil
    expect(get_stub).to have_been_requested
  end

end

