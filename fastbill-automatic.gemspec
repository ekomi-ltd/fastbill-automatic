# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "fastbill-automatic/version"

Gem::Specification.new do |s|
  s.name        = "fastbill-automatic"
  s.version     = Fastbill::Automatic::VERSION
  s.authors     = ["Sascha Korth"]
  s.email       = ["sascha.korth@zweitag.de"]
  s.homepage    = "https://github.com/skorth/fastbill-automatic"
  s.summary     = %q{API wrapper for Fastbill.}
  s.description = %q{API wrapper for Fastbill.}
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "json"
  s.add_development_dependency "rspec"
end
