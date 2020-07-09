# Format Buck Log output for Xcode
class BuckLogFormatter
  # Clang error message format, /(source_path) (error:) (error_message)/
  CLANG_ERROR_FORMAT = %r{(ios/.+:) (error:) (.+)}

  attr_reader :build_has_failed

  def initialize
    @build_has_failed = false
    @repo_root = ENV['REPO_ROOT']
  end

  # Consume a line from buck log and output it the way we want.
  def format_line(line)
    if line.start_with? 'BUILD FAILED'
      @build_has_failed = true
    end
    output_line = line.chomp

    # BACKGROUND: Buck outputs the same error message three times.
    # Two of them are during building and one is after build fails.
    # We only need the ones after 'BUILD FAILED'.
    # However, there's no straightforward way to filter out the
    # first two error mesasges, since they're mixed with regular logs.
    # Based on observation, it seems good enough that we can check
    # if the first letter is capitalized.
    if @build_has_failed && (m = output_line.match(CLANG_ERROR_FORMAT))
      # If the build has failed and the line matches clang error format,
      # we prepend $repo_root to make source path an absolute path.
      output_line = "#{@repo_root}/#{m.captures.join(' ')}"
    elsif !@build_has_failed && !/[[:upper:]]/.match(output_line[1])
      # If the build hasn't finished, we filter out all the messages
      # that not beginning with a capitalized letter.
      output_line = ''
    end
    puts output_line unless output_line.empty?
  end
end
