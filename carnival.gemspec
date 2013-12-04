# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carnival/version'

Gem::Specification.new do |spec|
  spec.name          = "carnival"
  spec.version       = Carnival::VERSION
  spec.authors       = ["Lukas Diener"]
  spec.email         = ["lukas.diener@hotmail.com"]
  spec.description   = "Mask your mailto-links to confuse spambots"
  spec.summary       = "Easily obfuscate e-mail-addresses displayed on your site. No more spam for you."
  spec.homepage      = "http://www.zeilenwerk.ch"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
