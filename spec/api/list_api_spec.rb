require 'spec_helper'

# unit tests for list
# List packages
# Returns a list of all available packages defined.
# @param [Hash] opts the optional parameters
# @option opts [String] :q Term to search within package names.
# @option opts [BOOLEAN] :include_versions Include versions of package in results.
# @option opts [String] :path The path to a specific package definition.
# @return [PackageList]
describe 'DefaultApi#list' do
  before do
    config = CrxPackageManager::Configuration.new
    @instance = CrxPackageManager::DefaultApi.new(CrxPackageManager::ApiClient.new(config))
  end

  let(:packages) do
    file = File.new(File.join(File.dirname(__FILE__), '..', 'files', 'list.json'))
    data = file.read
    data
  end

  it 'should work' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/list.jsp"
    ).to_return(status: 200, body: packages, headers: { 'Content-Type' => 'application/json' })

    data = @instance.list
    expect(data).to be_a(CrxPackageManager::PackageList)
    expect(data.total).to eq(4)
    expect(data.results).not_to be_nil
    entry = data.results[0]
    expect(entry).to be_a(CrxPackageManager::Package)
    expect(entry.pid).to eq('my_packages:test:1')
    expect(entry.filter).to be_a(Array)
    expect(entry.filter.length).to eq(2)
    filter = entry.filter[0]
    expect(filter).to be_a(CrxPackageManager::Filter)
    expect(filter.root).to eq('/content/dam/site')
    expect(filter.rules).to be_a(Array)
    expect(filter.rules.length).to eq(1)
    rule = filter.rules[0]
    expect(rule.modifier).to eq('exclude')
    expect(rule.pattern).to eq('.*/renditions/.*')
    filter = entry.filter[1]
    expect(filter.root).to eq('/content/site/en/errors')
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
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/list.jsp"
    ).to_return(status: 200, body: packages, headers: { 'Content-Type' => 'application/json' })

    data = @instance.list
    expect(data).to be_a(CrxPackageManager::PackageList)
    expect(data.total).to eq(4)
    expect(get_stub).to have_been_requested

  end

  it 'should support failures' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/list.jsp"
    ).to_return(status: 500)

    begin
      @instance.list
    rescue CrxPackageManager::ApiError => e
      expect(e).not_to be_nil
      expect(e.code).to eq(500)
    end

    expect(get_stub).to have_been_requested
  end

  it 'should support query param' do
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/list.jsp"
    ).with(query: { q: 'adobe' }
    ).to_return(status: 200, body: packages, headers: { 'Content-Type' => 'application/json' })

    data = @instance.list(q: 'adobe')
    expect(data).to be_a(CrxPackageManager::PackageList)
    expect(data.total).to eq(4)
    expect(get_stub).to have_been_requested

  end

  it 'should support includeVersions param' do
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/list.jsp"
    ).with(query: { includeVersions: false }
    ).to_return(status: 200, body: packages, headers: { 'Content-Type' => 'application/json' })

    data = @instance.list(include_versions: false)
    expect(data).to be_a(CrxPackageManager::PackageList)
    expect(data.total).to eq(4)
    expect(get_stub).to have_been_requested

  end

  it 'should ignore other params' do
    WebMock.reset!
    cfg = @instance.api_client.config
    get_stub = stub_request(
        :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/list.jsp"
    ).with(query: {}
    ).to_return(status: 200, body: packages, headers: { 'Content-Type' => 'application/json' })

    data = @instance.list(other_param: 'value')
    expect(data).to be_a(CrxPackageManager::PackageList)
    expect(data.total).to eq(4)
    expect(get_stub).to have_been_requested
  end
end
