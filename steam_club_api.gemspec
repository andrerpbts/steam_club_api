# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steam_club_api/version'

Gem::Specification.new do |spec|
  spec.name          = "steam_club_api"
  spec.version       = SteamClubAPI::VERSION
  spec.authors       = ["andrerpbts", "rodrigovirgilio"]
  spec.email         = ["andrerpbts@gmail.com", "virgilio@virgilio.eti.br"]
  spec.summary       = %q{Handles the interactions with Steam}
  spec.description   = %q{Handles the interactions with Steam}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "factory_girl", "~> 4.0"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "webmock", "~> 1.18.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec-virtus"

  spec.add_dependency "activesupport"
  spec.add_dependency "virtus"
  spec.add_dependency "httparty"
end
