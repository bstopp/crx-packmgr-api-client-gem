require 'spec_helper'

# unit tests for thumbnail
# Get package thumbnail
# Returns the package&#39;s thumbnail image.
# @param [Hash] opts the optional parameters
# @option opts [String] :path The path to the package.
# @return [File]
describe 'DefaultApi#thumbnail' do

  before do
    config = CrxPackageManager::Configuration.new
    @instance = CrxPackageManager::DefaultApi.new(CrxPackageManager::ApiClient.new(config))
  end

  let(:thumbnail) do
    file = File.new(File.join(File.dirname(__FILE__), '..', 'files', 'adobe-logo.jpg'))
    data = file.read
    data
  end

  it 'should work' do
    WebMock.reset!
    path = '/etc/packages/my_packages/package.zip'
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/thumbnail.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 200, body: thumbnail, headers: { 'Content-Type' => 'image/jpg' })

    data = @instance.thumbnail(path: path)
    expect(data).to be_a(Tempfile)
    expect(get_stub).to have_been_requested
  end

  it 'should support config changes' do
    WebMock.reset!
    path = '/etc/packages/my_packages/package.zip'
    @instance.api_client.config.configure do |c|
      c.scheme = 'https'
      c.host = 'notlocalhost'
      c.base_path = '/contextroot/crx/packgr'
      c.debugging = true
    end
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/thumbnail.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 200, body: thumbnail, headers: { 'Content-Type' => 'image/jpg' })

    data = @instance.thumbnail(path: path)
    expect(data).to be_a(Tempfile)
    expect(get_stub).to have_been_requested
  end

  it 'should support failures' do
    WebMock.reset!
    path = '/etc/packages/my_packages/package.zip'
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/thumbnail.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 404)

    begin
      @instance.thumbnail(path: path)
    rescue CrxPackageManager::ApiError => e
      expect(e).not_to be_nil
      expect(e.code).to eq(404)
    end

    expect(get_stub).to have_been_requested
  end

  it 'should ignore other params' do
    WebMock.reset!
    path = '/etc/packages/my_packages/package.zip'
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/thumbnail.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 200, body: thumbnail, headers: { 'Content-Type' => 'image/jpg' })

    data = @instance.thumbnail(path: path, other_param: 'value')
    expect(data).to be_a(Tempfile)
    expect(get_stub).to have_been_requested
  end

end
