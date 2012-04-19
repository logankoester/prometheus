module Prometheus
  module PluginDSL
    def readme(text = nil)
      @readme ||= text
    end

    def full_name(str = nil)
      @full_name ||= str
    end

    # Make sure the user has a complete config before continuing.
    def start
      if File.exists?(CONFIG_PATH)
        if Config.missing_configurables.size > 0
          Prometheus::Commands.new.invoke :upconfig
        else
          super
        end
      else
        Prometheus::Commands.new.invoke :config
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
