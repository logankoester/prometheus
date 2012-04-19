$interactive = false

require 'rubygems'
require File.expand_path('../prometheus/version', __FILE__)
%w{thor fileutils logger yaml settingslogic}.each { |r| require r }
require 'thor/group'

require File.expand_path('../prometheus/base', __FILE__)
