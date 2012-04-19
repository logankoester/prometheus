# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'prometheus/version'

Gem::Specification.new do |s|
  s.name        = "prometheus"
  s.version     = Prometheus::VERSION
  s.authors     = ["Logan Koester"]
  s.email       = ["logan@logankoester.com"]
  s.homepage    = "https://github.com/logankoester/prometheus"
  s.summary     = %q{A lightweight layer above Thor to quickly create beautiful command-line interfaces.}
  s.description = %q{A lightweight layer above Thor to quickly create beautiful command-line interfaces.}
  s.executables = ['prometheus']
  s.default_executable = %q{prometheus}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'thor'
  s.add_dependency 'settingslogic'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'rake'
end
