# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omg_pull_request/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ken Mazaika", "Jean Charles Sisk", "Master William Desmarais", "Ian Asaff"]
  gem.email         = ["kenmazaika@gmail.com"]
  gem.description   = %q{Have tests run automatically for your Github Pull Request}
  gem.summary       = %q{Have tests run automatically for your Github Pull Request}
  gem.homepage      = "http://github.com/where/omg_pull_request"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omg_pull_request"
  gem.require_paths = ["lib"]
  gem.version       = OmgPullRequest::VERSION

  gem.add_runtime_dependency(%q<aws-s3>)
  gem.add_runtime_dependency(%q<faraday>)
  gem.add_runtime_dependency(%q<github_api>)
  gem.add_runtime_dependency(%q<uuid>)
  gem.add_runtime_dependency(%q<rake>)
  gem.add_runtime_dependency(%q<activesupport>)
  gem.add_runtime_dependency(%q<i18n>)

end
