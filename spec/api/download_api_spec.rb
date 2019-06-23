require 'spec_helper'

# unit tests for download
# Download a package
# Downloads the package at the specified path. Returns a Tempfile object.
# @param [Hash] opts the optional parameters
# @option opts [String] :path The path to the package to download.
# @return [File]
describe 'DefaultApi#download' do
  before do
    config = CrxPackageManager::Configuration.new
    @instance = CrxPackageManager::DefaultApi.new(CrxPackageManager::ApiClient.new(config))
  end

  let(:dl) do
    file = File.new(File.join(File.dirname(__FILE__), '..', 'files', 'test-1.0.0.zip'))
    file
  end

  it 'should work' do
    WebMock.reset!
    path = '/etc/packages/my_packages/test-1.0.0.zip'
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/download.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 200, body: dl, headers: { 'Content-Type' => 'application/octet-stream' })

    data = @instance.download(path: path)
    expect(data).to be_a(Tempfile)
    expect(get_stub).to have_been_requested
    data.delete
  end

  it 'should support config changes' do
    WebMock.reset!
    path = '/etc/packages/my_packages/test-1.0.0.zip'
    @instance.api_client.config.configure do |c|
      c.scheme = 'https'
      c.host = 'notlocalhost'
      c.base_path = '/contextroot/crx/packgr'
    end
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/download.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 200, body: dl, headers: { 'Content-Type' => 'application/octet-stream' })

    data = @instance.download(path: path)
    expect(data).to be_a(Tempfile)
    expect(get_stub).to have_been_requested
    data.delete

  end

  it 'should support failures' do
    WebMock.reset!
    path = '/etc/packages/my_packages/test-1.0.0.zip'
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/download.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 404, headers: {})

    begin
      @instance.download(path: path)
    rescue CrxPackageManager::ApiError => e
      expect(e).not_to be_nil
      expect(e.code).to eq(404)
    end

    expect(get_stub).to have_been_requested
  end

  it 'should ignore other params' do
    WebMock.reset!
    path = '/etc/packages/my_packages/test-1.0.0.zip'
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/download.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 200, body: dl, headers: { 'Content-Type' => 'application/octet-stream' })

    data = @instance.download(path: path, other_param: 'value')
    expect(data).to be_a(Tempfile)
    expect(get_stub).to have_been_requested
    data.delete
  end

end