require 'spec_helper'
require 'xmlsimple'

describe 'DefaultApi#service' do

  before do
    config = CrxPackageManager::Configuration.new
    @instance = CrxPackageManager::DefaultApi.new(CrxPackageManager::ApiClient.new(config))
  end

  let(:service_resp) do
    file = File.new(File.join(File.dirname(__FILE__), '..', 'files', 'service_response.txt'))
    data = file.read
    data
  end

  let(:service_resp1) do
    file = File.new(File.join(File.dirname(__FILE__), '..', 'files', 'service_response1.txt'))
    data = file.read
    data
  end

  let(:ul) do
    file = File.new(File.join(File.dirname(__FILE__), '..', 'files', 'test-1.0.0.zip'))
    file
  end

  # unit tests for service_get
  # Generic operation service.
  # Provides endpoint for executing package manipulation commands.
  # @param cmd The command to execute.
  # @param [Hash] opts the optional parameters
  # @option opts [String] :name The name of the package on which to execute the command.
  # @option opts [String] :group The group of the package on which to execute the command.
  # @option opts [BOOLEAN] :strict Fail on an error.
  # @return [String]
  context 'get' do

    it 'should support cmd = help' do
      WebMock.reset!
      cfg = @instance.api_client.config
      get_stub = stub_request(
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'help' }
      ).to_return(status: 200, body: service_resp, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_get('help')
      parsed = XmlSimple.xml_in(xml, { ForceArray: %r(param), KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      expect(sr.version).to eq('1.4.1')
      expect(sr.user).to eq('admin')
      expect(sr.workspace).to eq('crx.default')
      expect(sr.request).not_to be_nil
      req = sr.request
      params = req.param
      expect(params).to be_a(Array)
      expect(params.length).to eq(1)
      expect(params[0].name).to eq('cmd')
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(get_stub).to have_been_requested
    end

    it 'should support cmd = ls' do
      WebMock.reset!
      cfg = @instance.api_client.config
      get_stub = stub_request(
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'ls' }
      ).to_return(status: 200, body: service_resp1, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_get('ls')
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      expect(sr.version).to eq('1.4.1')
      expect(sr.user).to eq('admin')
      expect(sr.workspace).to eq('crx.default')
      expect(sr.request).not_to be_nil
      req = sr.request
      params = req.param
      expect(params).to be_a(Array)
      expect(params.length).to eq(2)
      expect(params[0].name).to eq('cmd')
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(get_stub).to have_been_requested
    end

    it 'should support cmd = rm' do
      WebMock.reset!
      cfg = @instance.api_client.config
      get_stub = stub_request(
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'rm' }
      ).to_return(status: 200, body: service_resp1, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_get('rm')
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      expect(sr.version).to eq('1.4.1')
      expect(sr.user).to eq('admin')
      expect(sr.workspace).to eq('crx.default')
      expect(sr.request).not_to be_nil
      req = sr.request
      params = req.param
      expect(params).to be_a(Array)
      expect(params.length).to eq(2)
      expect(params[0].name).to eq('cmd')
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(get_stub).to have_been_requested
    end

    it 'should support cmd = build' do
      WebMock.reset!
      cfg = @instance.api_client.config
      get_stub = stub_request(
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'build' }
      ).to_return(status: 200, body: service_resp1, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_get('build')
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      expect(sr.version).to eq('1.4.1')
      expect(sr.user).to eq('admin')
      expect(sr.workspace).to eq('crx.default')
      expect(sr.request).not_to be_nil
      req = sr.request
      params = req.param
      expect(params).to be_a(Array)
      expect(params.length).to eq(2)
      expect(params[0].name).to eq('cmd')
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(get_stub).to have_been_requested
    end

    it 'should support cmd = inst' do
      WebMock.reset!
      cfg = @instance.api_client.config
      get_stub = stub_request(
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'inst' }
      ).to_return(status: 200, body: service_resp1, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_get('inst')
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      expect(sr.version).to eq('1.4.1')
      expect(sr.user).to eq('admin')
      expect(sr.workspace).to eq('crx.default')
      expect(sr.request).not_to be_nil
      req = sr.request
      params = req.param
      expect(params).to be_a(Array)
      expect(params.length).to eq(2)
      expect(params[0].name).to eq('cmd')
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(get_stub).to have_been_requested
    end

    it 'should support cmd = uninst' do
      WebMock.reset!
      cfg = @instance.api_client.config
      get_stub = stub_request(
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'uninst' }
      ).to_return(status: 200, body: service_resp1, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_get('uninst')
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      expect(sr.version).to eq('1.4.1')
      expect(sr.user).to eq('admin')
      expect(sr.workspace).to eq('crx.default')
      expect(sr.request).not_to be_nil
      req = sr.request
      params = req.param
      expect(params).to be_a(Array)
      expect(params.length).to eq(2)
      expect(params[0].name).to eq('cmd')
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(get_stub).to have_been_requested
    end

    it 'should support cmd = get' do
      WebMock.reset!
      cfg = @instance.api_client.config
      get_stub = stub_request(
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'get' }
      ).to_return(status: 200, body: service_resp1, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_get('get')
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      expect(sr.version).to eq('1.4.1')
      expect(sr.user).to eq('admin')
      expect(sr.workspace).to eq('crx.default')
      expect(sr.request).not_to be_nil
      req = sr.request
      params = req.param
      expect(params).to be_a(Array)
      expect(params.length).to eq(2)
      expect(params[0].name).to eq('cmd')
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
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
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'help' }
      ).to_return(status: 200, body: service_resp1, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_get('help')
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      expect(sr.version).to eq('1.4.1')
      expect(sr.user).to eq('admin')
      expect(sr.workspace).to eq('crx.default')
      expect(sr.request).not_to be_nil
      req = sr.request
      params = req.param
      expect(params).to be_a(Array)
      expect(params.length).to eq(2)
      expect(params[0].name).to eq('cmd')
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(get_stub).to have_been_requested
    end

    it 'should not allow invalid commands' do
      WebMock.reset!
      begin
        @instance.service_get('invalid')
      rescue ArgumentError => e
        expect(e).not_to be_nil
        expect(e.message).to match(/be one of/)
      end
    end

    it 'should support failures' do
      WebMock.reset!
      cfg = @instance.api_client.config
      get_stub = stub_request(
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'help' }
      ).to_return(status: 500)

      begin
        @instance.service_get('help')
      rescue CrxPackageManager::ApiError => e
        expect(e).not_to be_nil
        expect(e.code).to eq(500)
      end

      expect(get_stub).to have_been_requested
    end

    it 'should ignore other params' do
      WebMock.reset!
      cfg = @instance.api_client.config
      get_stub = stub_request(
          :get, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).with(query: { cmd: 'help' }
      ).to_return(status: 200, body: service_resp1, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_get('help', other_param: 'value')
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(get_stub).to have_been_requested
    end
  end

  # unit tests for service_post
  # Generic operation service.
  # Provides endpoint for
  # @param file Package file to upload
  # @param [Hash] opts the optional parameters
  # @option opts [String] :name The hint for the package&#39;s name if the definiton doesn&#39;t have one.
  # @option opts [BOOLEAN] :strict Fail on an error.
  # @option opts [BOOLEAN] :force Force the package upload.
  # @option opts [BOOLEAN] :install Install the package upon upload
  # @return [String]
  context 'post' do
    it 'should work' do
      WebMock.reset!
      cfg = @instance.api_client.config
      post_stub = stub_request(
          :post, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).to_return(status: 200, body: service_resp, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_post(ul)
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(post_stub).to have_been_requested
    end

    it 'should support config changes' do
      @instance.api_client.config.configure do |c|
        c.scheme = 'https'
        c.host = 'notlocalhost'
        c.base_path = '/contextroot/crx/packgr'
      end
      cfg = @instance.api_client.config
      post_stub = stub_request(
          :post, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).to_return(status: 200, body: service_resp, headers: { 'Content-Type' => 'text/plain' })

      xml = @instance.service_post(ul)
      parsed = XmlSimple.xml_in(xml, { ForceArray: false, KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
      expect(post_stub).to have_been_requested
    end

    it 'should require file' do
      cfg = @instance.api_client.config
      begin
        @instance.service_post(nil)
      rescue ArgumentError => e
        expect(e).not_to be_nil
        expect(e.message).to match(/required parameter 'file'/)
      end
    end

    it 'should support failures' do
      WebMock.reset!
      cfg = @instance.api_client.config
      post_stub = stub_request(
          :post, "#{cfg.scheme}://#{cfg.host}#{cfg.base_path}/service.jsp"
      ).to_return(status: 500)

      begin
        @instance.service_post(ul)
      rescue CrxPackageManager::ApiError => e
        expect(e).not_to be_nil
        expect(e.code).to eq(500)
      end

      expect(post_stub).to have_been_requested
    end
  end
end