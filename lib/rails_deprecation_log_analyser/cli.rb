# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class CLI
    def run(args = ARGV)
      log_file_path = args[0]
      checkstyle_path = args[1]
      source_directory = args[2]

      help_text = 'bundle exec rails_derecation_log_analyser log_file_path, checkstyle_output_path, source_directory_path'
      raise ArgumentError, 'Missing log file path. ' + help_text if log_file_path.nil?

      nitra_build_log = LogSource::Nitra.new(log_file_path)
      checkstyle = Formatter::CheckstyleFormatter.new

      configuration = Configuration.new(nitra_build_log, [checkstyle], source_directory)
      parser = LogParser.new(configuration)

      parser.parse

      File.open(checkstyle_path, 'w') do |io|
        checkstyle.write(io)
      end unless checkstyle_path.nil?

      return 0
    rescue StandardError, SyntaxError => e
      $stderr.puts e.message
      $stderr.puts e.backtrace
      return 2
    end
  end
end
