module Prometheus
  class Config < Settingslogic
    source ::CONFIG_PATH
    class << self
      attr_accessor :configurables

      # Options for hash:
      #   :label => 'Some Configurable'
      #   :default => 'default value'
      def ask(shell, key, opts={})
        default = Config[key] || opts[:default]
        opts[:label] ||= key
        answer = shell.ask(opts[:label] + " [#{default}]>")
        Config[key] = (answer.size > 0) ? answer : default
      end

      def save(shell = Thor::Shell::Basic.new)
        out = {}.update(self)
        begin
          File.open(CONFIG_PATH, 'w') { |f| f << out.to_yaml }
          puts
          shell.say 'Configuration saved!', :blue
          puts
        rescue Exception => e
          shell.say e, :red
        end
      end

      def configure(shell = Thor::Shell::Basic.new)
        if @configurables
          @configurables.each do |plugin, configurables|
            shell.say plugin, :blue
            configurables.each do |c|
              Config.ask(shell, c[:key], :label => "  #{c[:label]}", :default => c[:default])
            end
          end

          Config.save
        else
          shell.say 'No plugins require configuration'
        end
      end

      # Return an array of configurable keys that are not found in the user's config
      def missing_configurables
        return [] unless @configurables
        configurable_keys = @configurables.map { |k, v| v.map { |i| i[:key].to_s } }.flatten
        configurable_keys.reject { |k| Config.keys.include? k }
      end

    end
  end
end
