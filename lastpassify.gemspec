lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lastpassify/version"

Gem::Specification.new do |spec|
  spec.name = "lastpassify"
  spec.version = LastPassify::VERSION
  spec.authors = ["Eric Eklund (eeklund), Remy Abdullahi (abdu0299)"]
  spec.email = ["eeklund@umn.edu", "abdu0299@umn.edu"]

  spec.summary = "Populate ERB file with values from LastPass"
  spec.description = "This gem populates a given ERB/YAML file with values from LastPass using LastPass-CLI."
  spec.homepage = "https://github.com/umn-asr/lastpassify"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3.0"

  spec.add_development_dependency "aruba", "~> 0.14.2"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "bundler-audit"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "reek"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "standard"

  spec.add_dependency "thor"
end
