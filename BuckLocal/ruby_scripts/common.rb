require 'English'
require 'open3'
require 'fileutils'

# Wrap text in terminal color codes
module Color
  def self.blue(message)
    wrap(34, message)
  end

  def self.gray(message)
    wrap(37, message)
  end

  def self.yellow(message)
    wrap(33, message)
  end

  def self.red(message)
    wrap(31, message)
  end

  def self.green(message)
    wrap(32, message)
  end

  def self.dim(message)
    wrap(2, message)
  end

  # Wrap a chunk of text in shell color codes (if not in Xcode)
  def self.wrap(color_code, message)
    if ENV['BUILDING_FROM_XCODE']
      message
    else
      "\e[#{color_code}m#{message}\e[0m"
    end
  end
end

# Log messages to the terminal

def log(message)
  puts Color.blue(message)
end

def log_info(message)
  puts message
end

def log_command(message)
  prefix = dry_run? ? Color.blue('Dry run: ') : ''
  puts prefix + Color.gray(message)
end

def warning(message)
  puts Color.yellow(message)
end

def error(message)
  warn Color.red(message)
end

def success(message)
  puts Color.green(message)
end

def debug(message)
  puts Color.dim(message)
end

def debug_stderr(message)
  $stderr.puts Color.dim(message)
end

def log_failed(command)
  puts Color.red('Error running command: ') + Color.gray(command)
end

# Log a message that becomes a message grouping on Buildkite
def log_group(message)
  if $stdout.isatty
    log message
  else
    log "+++ #{message}"
  end
end

# System Commands

# Run a system command, optionally redact sensitive keys, optionally pass block
# to run on failure
def system_and_log(command, redacted: nil, prefix: '', exit_on_failure: true, &on_failure)
  command_to_log = prefix + command
  if redacted.nil?
    log_command command_to_log
  else
    log_command redact(command_to_log, redacted)
  end

  return if dry_run? # Don't actually run commands in dry-run mode

  run_command(command, redacted, exit_on_failure: exit_on_failure, &on_failure)
end

def run_command(command, redacted = nil, exit_on_failure: true)
  begin
    Kernel.system(command)
  rescue Interrupt
    error_and_exit ' Task cancelled.'
  end

  # Command has succeeded
  return 0 if $CHILD_STATUS.nil?
  return 0 if $CHILD_STATUS.exitstatus.nil?
  return 0 if $CHILD_STATUS.exitstatus.zero?

  # Command has failed
  yield if block_given?
  log_command_error(command, redacted, exit_process: exit_on_failure)

  # Command failed and 'exit_on_failure' is false (return exit-status for child)
  $CHILD_STATUS.exitstatus
end

# Get the output of a 'system' command, raise exception on failure
def system_output_and_log(command, prefix: '')
  log_command prefix + command
  return if dry_run? # Don't actually run commands in dry-run mode

  system_output(command)
end

# Get the output of a 'system' command, raise exception on failure
def system_output(command)
  begin
    stdout, stderr, status = Open3.capture3(command)
  rescue SystemCallError
    log_failed command
    raise # existing exception
  end

  unless status.success?
    error "stdout: #{stdout}" unless stdout.empty?
    error "stderr: #{stderr}" unless stderr.empty?
    log_command_error command
  end

  stdout.strip
end

def redact(command, redacted = nil)
  Array(redacted).each do |secret|
    command = command.gsub(secret, '******') unless secret.empty?
  end
  command
end

# This will always print out the command that failed, and end with SystemExit
def log_command_error(command, redacted = nil, exit_process: true)
  if redacted.nil?
    log_failed command
  else
    log_failed redact(command, redacted)
  end

  exit(1) if exit_process
end

def error_and_exit(message = nil, exit_code: 1)
  error message unless message.nil?
  exit(exit_code)
end

# Detect 'dry run' mode (just log commands, don't run them)
def dry_run?
  !ENV['dry_run'].nil?
end

# Detect 'idempotent' mode
# https://git.musta.ch/airbnb/apps/blob/master/ios/pipelines/_infra/docs/style_guide.md#support-idempotent-mode-recommended
def idempotent_job?
  value = ENV['IS_IDEMPOTENT_JOB']
  return false if value.nil?
  return value.downcase == 'true'
end

# Like run_command except returns with status code instead of exiting and
# does not run any additional blocks of code
def run_command_and_return_code(command, suppress_output: false, print_command: false)
  begin
    log_command(command) if print_command
    if suppress_output
      Kernel.system(command, out: File::NULL, err: File::NULL)
    else
      Kernel.system(command)
    end
  rescue Interrupt
    error 'Task cancelled.'
    # According to this: http://www.tldp.org/LDP/abs/html/exitcodes.html 130 is exit code for ctl + c
    return 130
  end
  $CHILD_STATUS&.exitstatus
end

# Other utilities

def time_commands
  start_time = system_output 'date +%s'
  yield
  end_time = system_output 'date +%s'
  end_time.to_i - start_time.to_i
end

def write_to_file(content, path)
  File.open(path, 'w') do |file|
    file.puts content
  end
end

def argument_or_fail(name)
  key = ENV[name]
  raise ArgumentError, "Must pass value for '#{name}'" if key.nil?

  key
end

def create_directory(name, quiet: false)
  if File.directory?(name)
    nil
  else
    log "Creating directory #{name}" unless quiet
    FileUtils.mkdir_p name
  end
end

def contents_of_file(name)
  File.open(name, 'r').read
end

def append_to_file(content, path)
  File.open(path, 'a') do |file|
    file.puts content
  end
end

def copy_if_updated(source, destination)
  return unless File.file?(source)

  # We use File.ctime instead of FileUtils.uptodate? because ctime is more accurate
  # than the mtime FileUtils.uptodate? uses.
  # For example, when Buck download an artifact from http cache, its ctime would be
  # correctly set to the download time, while its mtime would be a mysterious
  # "Fri Feb  1 08:00:00 UTC 1985"
  if !File.exist?(destination) || (File.ctime(source) >= File.ctime(destination))
    begin
      FileUtils.cp(source, destination)
    rescue Errno::EACCES # Permission denied
      # Copy may fail due to the lack of permission. For exmaple, the destination is read-only (444).
      # If this is the case, we remove the file (read-only can be deleted) and copy again.
      # If the copy is still not successful, the error will be exposed.
      FileUtils.rm_f(destination)
      FileUtils.cp(source, destination)
    end
  end
end
