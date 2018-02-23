# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/github_job_status/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-github_job_status'
  spec.version       = Fastlane::GithubJobStatus::VERSION
  spec.author        = %q{Justin Singer}
  spec.email         = %q{justinsinger1@gmail.com}

  spec.summary       = %q{Post the status of your test jobs to your pull requests}
  spec.homepage      = "https://github.com/justinsinger/fastlane_plugins/tree/github_job_status/fastlane-plugin-github_job_status"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client', '>= 2.0.2'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane'
end
