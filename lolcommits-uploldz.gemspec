lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lolcommits/uploldz/version'

Gem::Specification.new do |spec|
  spec.name     = "lolcommits-uploldz"
  spec.version  = Lolcommits::Uploldz::VERSION
  spec.authors  = ["Matthew Hutchinson"]
  spec.email    = ["matt@hiddenloop.com"]
  spec.summary  = %q{Uploads lolcommits to a remote server}
  spec.homepage = "https://github.com/lolcommits/lolcommits-uploldz"
  spec.license  = "LGPL-3.0"

  spec.description = <<-DESC
  Uploads lolcommits to a remote server, with optional key or  HTTP based
  authentication.
  DESC

  spec.metadata = {
    "homepage_uri"      => "https://github.com/lolcommits/lolcommits-uploldz",
    "changelog_uri"     => "https://github.com/lolcommits/lolcommits-uploldz/blob/master/CHANGELOG.md",
    "source_code_uri"   => "https://github.com/lolcommits/lolcommits-uploldz",
    "bug_tracker_uri"   => "https://github.com/lolcommits/lolcommits-uploldz/issues",
    "allowed_push_host" => "https://rubygems.org"
  }

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(assets|test|features)/}) }
  spec.test_files    = `git ls-files -- {test,features}/*`.split("\n")
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.4"

  spec.add_runtime_dependency "rest-client", ">= 2.1.0"
  spec.add_runtime_dependency "lolcommits", ">= 0.14.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "simplecov"
end
