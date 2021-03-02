require 'buck_log_formatter'

describe BuckLogFormatter do
  BUILD_FAILED_MESSAGE = 'BUILD FAILED ....'

  def simulate_build_failed(buck_log_formatter:)
    expect do
      buck_log_formatter.format_line(BUILD_FAILED_MESSAGE)
    end.to output(BUILD_FAILED_MESSAGE + "\n").to_stdout
  end

  describe '#format_line' do
    it 'filters out a line not beginning with a captial letter' do
      buck_log_formatter = BuckLogFormatter.new
      expect do
        buck_log_formatter.format_line('  clutter message')
      end.to output('').to_stdout
    end

    it 'outputs a line beginning with a captial letter' do
      buck_log_formatter = BuckLogFormatter.new
      expect do
        buck_log_formatter.format_line('BUILT //ios/lib/Module')
      end.to output("BUILT //ios/lib/Module\n").to_stdout
    end

    it 'set the build_has_failed status base on the input' do
      buck_log_formatter = BuckLogFormatter.new
      expect(buck_log_formatter.build_has_failed).to eq false
      simulate_build_failed(buck_log_formatter: buck_log_formatter)
      expect(buck_log_formatter.build_has_failed).to eq true
    end

    it 'outputs non error line when build is failed' do
      buck_log_formatter = BuckLogFormatter.new
      simulate_build_failed(buck_log_formatter: buck_log_formatter)
      expect do
        buck_log_formatter.format_line('  var imageURL: URL? { get }')
      end.to output("  var imageURL: URL? { get }\n").to_stdout
    end

    it 'outputs error line with absolute path when build is failed' do
      ENV['REPO_ROOT'] = '/usr/home/apps'
      buck_log_formatter = BuckLogFormatter.new
      simulate_build_failed(buck_log_formatter: buck_log_formatter)
      expect do
        buck_log_formatter.format_line('ios/lib/Module/Source/SourceFile.swift:11: error: something is wrong')
      end.to output("/usr/home/apps/ios/lib/Module/Source/SourceFile.swift:11: error: something is wrong\n").to_stdout
      ENV['REPO_ROOT'] = nil
    end
  end
end
