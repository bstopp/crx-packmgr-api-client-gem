require 'spec_helper_acceptance'
require 'xmlsimple'

describe 'DefaultApi' do
  before do
    # run before each test
    config = CrxPackageManager::Configuration.new
    config.username = 'admin'
    config.password = 'admin'
    @instance = CrxPackageManager::DefaultApi.new(CrxPackageManager::ApiClient.new(config))
  end

  after do
    # run after each test
  end

  let(:package) do
    file = File.new(File.join(File.dirname(__FILE__), '..', 'files', 'test-1.0.0.zip'))
    file
  end

  let(:path) do
    '/etc/packages/my_packages/test-1.0.0.zip'
  end

  context 'init' do
    it 'should work' do
      data = @instance.init
      expect(data).to be_a(CrxPackageManager::InitData)
      expect(data.context_path).to eq('/crx')
      expect(data.launchpad_context_path).to eq('/')
      expect(data.jcr_version).to eq('2.0')
      expect(data.workspace).to eq('crx.default')
      expect(data.user_id).to eq('Administrator')
      expect(data.workspaces).to eq(['crx.default'])
    end
  end

  context 'installstatus' do
    it 'should work' do
      data = @instance.installstatus
      expect(data).to be_a(CrxPackageManager::InstallStatus)
      expect(data.status.finished).to eq(true)
      expect(data.status.item_count).to eq(0)
    end
  end


  context 'service upload and update' do
    it 'should support cmd=help' do
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
    end

    it 'should support post' do
      xml = @instance.service_post(package)
      parsed = XmlSimple.xml_in(xml, { ForceArray: %r(param), KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
    end

    it 'should support install' do
      xml = @instance.service_get('inst', name: 'test')
      parsed = XmlSimple.xml_in(xml, { ForceArray: %r(param), KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
    end

  end

  context 'list' do
    it 'should work' do
      data = @instance.list(q: 'test')
      expect(data).to be_a(CrxPackageManager::PackageList)
      expect(data.total).to eq(1)
      expect(data.results).not_to be_nil
      entry = data.results[0]
      expect(entry).to be_a(CrxPackageManager::Package)
      expect(entry.pid).to eq('my_packages:test:1.0.0')
    end
  end

  context 'groups' do
    it 'should work' do
      data = @instance.groups(only_top_level: true)
      expect(data).to be_a(CrxPackageManager::GroupList)
      expect(data.groups).not_to be_nil
      data.groups.each do |grp|
        next if grp.name != 'my_packages'
        expect(grp.title).to eq('my_packages')
        expect(grp.count).to eq(1)
        expect(grp.deep_count).to eq(1)
      end
    end
  end

  context 'thumbnail' do
    it 'should work' do
      data = @instance.thumbnail(path: path)
      expect(data).to be_a(Tempfile)
    end

  end

  context 'download' do
    it 'should work' do
      data = @instance.download(path: '/etc/packages/my_packages/test-1.0.0.zip')
      expect(data).to be_a(Tempfile)
    end

  end

  context 'service uninstall and remove' do
    it 'should support uninstall' do
      xml = @instance.service_get('uninst', name: 'test')
      parsed = XmlSimple.xml_in(xml, { ForceArray: %r(param), KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
    end

    it 'should support rm' do
      xml = @instance.service_get('rm', name: 'test')
      parsed = XmlSimple.xml_in(xml, { ForceArray: %r(param), KeyToSymbol: true, AttrToSymbol: true } )
      sr = CrxPackageManager::ServiceResponse.new
      sr = sr.build_from_hash(parsed)
      response = sr.response
      expect(response.status[:code].to_i).to eq(200)
    end
  end

end
