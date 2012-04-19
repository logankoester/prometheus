require_relative 'lib/config'

module Prometheus
  class Commands < Prometheus::Base
    include Thor::Actions

    full_name 'Prometheus Shell'
    namespace :prometheus
    source_root TEMPLATES_PATH
    configurable self, :project_root, :label => 'Project root'

    desc 'config', "Write configuration to #{CONFIG_PATH} (interactive)"
    def config
      if File.exists?(CONFIG_PATH)
        Config.configure(self)
      else
        say "Welcome to #{APP_NAME}! You must be new, since you don't have a configuration file :-)", :blue
        if yes? "Okay to create at #{CONFIG_PATH}? (Y/N)", :green
          copy_file "default_config.yml", CONFIG_PATH
          Config.configure(self)
        else
          say 'Sorry, you have to create a configuration file to proceed.', :red
          exit
        end
      end
    end

    desc 'upconfig', 'Update configuration to fix missing values', :hide => true
    def upconfig
      say "Some configuration options have changed, please review", :green
      say "You are missing: #{Config.missing_configurables.join(', ')}", :red
      Config.configure(self)
    end

  end
end
