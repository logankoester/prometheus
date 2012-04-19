module Prometheus
  module PluginDSL
    # Make sure the user has a complete config before continuing.
    def start
      if File.exists? CONFIG_PATH
        if Config.missing_configurables.size > 0
          Prometheus::ConfigCommands.new.invoke :repair
        else
          super
        end
      else
        Prometheus::ConfigCommands.new.invoke :edit
      end
    end

    # Options for hash:
    #   :label => 'Some Configurable'
    #   :default => 'default value'
    def configurable(klass, key, opts={})
      opts[:key] = key
      opts[:label] ||= key
      Config.configurables ||= {}
      Config.configurables[klass.full_name] ||= []
      Config.configurables[klass.full_name] << opts
    end
  end
end
