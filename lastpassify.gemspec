# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lastpassify/version'

Gem::Specification.new do |spec|
  spec.name          = "lastpassify"
  spec.version       = LastPassify::VERSION
  spec.authors       = ["Eric Eklund (eeklund), Remy Abdullahi (abdu0299)"]
  spec.email         = ["eeklund@umn.edu", "abdu0299@umn.edu"]

  spec.summary       = %q{Populate ERB file with values from LastPass}
  spec.description   = %q{This gem populates a given ERB/YAML file with values from LastPass using LastPass-CLI.}
  spec.homepage      = "https://github.umn.edu/asrweb/lastpassify"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems-local"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "reek"
  spec.add_development_dependency "overcommit"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "aruba", "~> 0.14.2"
  spec.add_development_dependency "rspec"
  spec.add_dependency "thor"
end
