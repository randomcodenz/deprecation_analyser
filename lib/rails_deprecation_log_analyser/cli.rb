# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class CLI
    def run(args = ARGV)
      log_file_path = args[0]
      checkstyle_path = args[1]

      nitra_build_log = LogSource::Nitra.new(log_file_path)
      checkstyle = Formatter::CheckstyleFormatter.new

      configuration = Configuration.new(nitra_build_log, [checkstyle])
      parser = LogParser.new(configuration)

      parser.parse

      File.open(checkstyle_path, 'w') do |io|
        checkstyle.write(io)
      end

      return 0
    rescue StandardError, SyntaxError => e
      $stderr.puts e.message
      $stderr.puts e.backtrace
      return 2
    end
  end
end
