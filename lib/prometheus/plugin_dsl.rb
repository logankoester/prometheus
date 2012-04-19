module Prometheus
  module PluginDSL

    def readme(text = nil)
      @readme ||= text
    end

    def full_name(str = nil)
      @full_name ||= str
    end

  end
end
