# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_repo_sort/version'

Gem::Specification.new do |spec|
  spec.name          = GitHubRepoSort::PROJECT
  spec.version       = GitHubRepoSort::VERSION
  spec.authors       = ['dkhamsing']
  spec.email         = ['dkhamsing8@gmail.com']

  spec.summary       = 'Sort a list of GitHub repos'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/dkhamsing/github_repo_sort'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = [spec.name]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'octokit'
  spec.add_runtime_dependency 'parallel'
  spec.add_runtime_dependency 'netrc'
  spec.add_runtime_dependency 'ruby-progressbar'
end
