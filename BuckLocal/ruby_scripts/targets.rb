require 'common'

module BuckLocal
  # A class encapsulating buck targerts
  class Targets
    def self.all_deps(target_name)
      self.get_query_output("deps('#{target_name}')").lines.map(&:chomp)
    end

    def self.get_query_output(query_string)
      system_output "#{ENV['buck_binary_path']} query \"#{query_string}\""
    end
  end
end
