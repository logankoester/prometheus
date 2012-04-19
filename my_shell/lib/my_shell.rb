require_relative "my_shell/version"
require 'prometheus'

module MyShell
  APP_NAME = 'MyShell'
  CONFIG_PATH = "#{ENV['HOME']}/.#{APP_NAME}/config"
  TEMPLATES_PATH = File.expand_path('../../templates', __FILE__)
  PROMPT='MyShell'

  # Load all modules
  Dir['lib/plugins/**/*_commands.rb'].each { |m| require File.expand_path("../../#{m}", __FILE__) }

  module MyShell
    include Prometheus

    class Commands < Prometheus::Commands
      readme File.read(File.expand_path('../../README.md', __FILE__))
    end
  end
end
