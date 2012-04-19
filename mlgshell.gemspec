# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mlgshell/version"

Gem::Specification.new do |s|
  s.name        = "mlgshell"
  s.version     = Mlgshell::VERSION
  s.authors     = ["Logan Koester"]
  s.email       = ["logan@logankoester.com"]
  s.homepage    = ""
  s.summary     = %q{mlgshell: a command line interface to all our cross-property MLG tasks.}
  s.description = %q{mlgshell is intended to help automate tasks that extend beyond any single application, such as VM provisioning, etc.}
  s.executables = ['mlg']
  s.default_executable = %q{mlg}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'thor'
  s.add_dependency 'settingslogic'
  s.add_dependency 'clipboard'
  s.add_dependency 'paint'
  s.add_dependency 'active_support'
end
