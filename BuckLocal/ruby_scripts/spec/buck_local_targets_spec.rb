
require 'targets'
require 'fileutils'

describe BuckLocal::Targets do
  ROOT_DIR = File.expand_path('../../../', __dir__)

  before(:all) do
    # Prepare test BUCK file
    FileUtils.cp "#{ROOT_DIR}/BuckLocal/tests_fixture/BUCK.fixture", "#{ROOT_DIR}/BuckLocal/tests_fixture/BUCK"
  end

  after(:all) do
    # Remove teset BUCK file
    FileUtils.rm "#{ROOT_DIR}/BuckLocal/tests_fixture/BUCK"
  end

  subject do
    all_deps = BuckLocal::Targets.all_deps('//BuckLocal/tests_fixture:Lib0')
    BuckLocal::Targets.new(all_deps)
  end

  describe '#apple_library_targets' do
    it 'gets all apple_library targets' do
      expected_target_names = [
        '//BuckLocal/tests_fixture:Lib0#iphonesimulator-x86_64,static',
        '//BuckLocal/tests_fixture:Lib1#iphonesimulator-x86_64,static',
        '//BuckLocal/tests_fixture:Lib2#iphonesimulator-x86_64,static',
        '//BuckLocal/tests_fixture:Lib3#iphonesimulator-x86_64,static',
      ]
      expect(subject.class.qualified_names(subject.apple_library_targets)).to match_array(expected_target_names)
    end
  end

  describe '#cxx_library_targets' do
    it 'gets all cxx_library targets' do
      expected_target_names = [
        '//BuckLocal/tests_fixture:CxxLib#iphonesimulator-x86_64,static',
      ]
      expect(subject.class.qualified_names(subject.cxx_library_targets)).to match_array(expected_target_names)
    end
  end

  describe '#prebuilt_cxx_library_targets' do
    it 'gets all prebuilt_cxx_library targets' do
      expected_target_names = [
        '//BuckLocal/tests_fixture:PrebuiltLib1',
      ]
      expect(subject.class.qualified_names(subject.prebuilt_cxx_library_targets)).to match_array(expected_target_names)
    end
  end

  describe '#apple_asset_catalog' do
    it 'gets all apple_asset_catalog targets' do
      expected_target_names = [
        '//BuckLocal/tests_fixture:AssetCatalog1',
      ]
      expect(subject.class.qualified_names(subject.apple_asset_catalog_targets)).to match_array(expected_target_names)
    end
  end

  describe '#apple_bundle_targets' do
    it 'gets all apple_bundle targets' do
      expected_target_names = [
        '//BuckLocal/tests_fixture:Bundle1',
      ]
      expect(subject.class.qualified_names(subject.apple_bundle_targets)).to eq(expected_target_names)
    end
  end
end
