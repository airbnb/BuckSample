require 'query'
require 'tempfile'

describe BuckLocal::Query do
  describe '#generate_dep_list_file' do
    it 'generates a file with dependency list information' do
      target_name = '//Libraries/SecondSwiftModule:SecondSwiftModule'

      output_file_path = Tempfile.new('deps.list')
      subject.class.generate_dep_list_file(target_name, output_file_path)

      deps_list = output_file_path.read.strip
      expect(deps_list).to eq('[{"target_name":"//Libraries/SecondSwiftModule:SecondSwiftModule","modular":true},{"target_name":"//Libraries/YetAnotherSwiftModule:YetAnotherSwiftModule","modular":true}]')
    end
  end
end
