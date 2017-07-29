# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_deprecation_log_analyser/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_deprecation_log_analyser"
  spec.version       = RailsDeprecationLogAnalyser::VERSION
  spec.authors       = ["neal.blomfield"]
  spec.email         = ["randomcodenz@users.noreply.github.com"]

  spec.summary       = "Analyse rails deprecation warnings contained in a log."
  spec.description   = "Analyse rails deprecation warnings contained in a log and output them in various formats to enable reporting in CI environments."
  spec.homepage      = "https://github.com/randomcodenz/rails_deprecation_log_analyser"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "none"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
