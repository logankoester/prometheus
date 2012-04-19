require_relative 'lib/config'
require_relative 'lib/plugin_dsl'

module Prometheus
  class ConfigCommands < Prometheus::Base
    include Thor::Actions

    full_name 'Configuration Management'
    namespace :config
    def self.source_root; TEMPLATES_PATH; end
    readme File.read(File.expand_path('../README', __FILE__))

    desc 'edit', "Write configuration to #{CONFIG_PATH} (interactive)"
    def edit
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

    desc 'repair', 'Update configuration to fix missing values', :hide => true
    def repair
      say "Some configuration options have changed, please review", :green
      say "You are missing: #{Config.missing_configurables.join(', ')}", :red
      Config.configure(self)
    end

  end
end
