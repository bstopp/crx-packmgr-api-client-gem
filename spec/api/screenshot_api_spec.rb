require 'spec_helper'

# unit tests for screenshot
# Get screenshot
# Returns the screenshot at the specified path.
# @param [Hash] opts the optional parameters
# @option opts [String] :path The path to the screenshot.
# @return [File]
describe 'DefaultApi#screenshot' do

  before do
    config = CrxPackageManager::Configuration.new
    @instance = CrxPackageManager::DefaultApi.new(CrxPackageManager::ApiClient.new(config))
  end

  let(:screenshot) do
    file = File.new(File.join(File.dirname(__FILE__), '..', 'files', 'adobe-logo.jpg'))
    data = file.read
    data
  end

  it 'should work' do
    WebMock.reset!
    path = '/path/to/a/screenshot.jpg'
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/screenshot.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 200, body: screenshot, headers: { 'Content-Type' => 'image/jpg' })

    data = @instance.screenshot(path: path)
    expect(data).to be_a(Tempfile)
    expect(get_stub).to have_been_requested
  end

  it 'should support config changes' do
    WebMock.reset!
    path = '/path/to/a/screenshot.jpg'
    @instance.api_client.config.configure do |c|
      c.scheme = 'https'
      c.host = 'notlocalhost'
      c.base_path = '/contextroot/crx/packgr'
      c.debugging = true
    end
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/screenshot.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 200, body: screenshot, headers: { 'Content-Type' => 'image/jpg' })

    data = @instance.screenshot(path: path)
    expect(data).to be_a(Tempfile)
    expect(get_stub).to have_been_requested
  end

  it 'should support failures' do
    WebMock.reset!
    path = '/path/to/a/screenshot.jpg'
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/screenshot.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 404)

    begin
      @instance.screenshot(path: path)
    rescue CrxPackageManager::ApiError => e
      expect(e).not_to be_nil
      expect(e.code).to eq(404)
    end

    expect(get_stub).to have_been_requested
  end

  it 'should ignore other params' do
    WebMock.reset!
    path = '/path/to/a/screenshot.jpg'
    cfg = @instance.api_client.config
    get_stub = stub_request(
      :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/screenshot.jsp"
    ).with(
      query: { path: path }
    ).to_return(status: 200, body: screenshot, headers: { 'Content-Type' => 'image/jpg' })

    data = @instance.screenshot(path: path, other_param: 'value')
    expect(data).to be_a(Tempfile)
    expect(get_stub).to have_been_requested
  end

end
