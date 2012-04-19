require_relative 'plugin_dsl'
require_relative 'repl'

module Prometheus
  class Base < Thor
    extend PluginDSL
    class << self
      def repl_banner
        "\e[34m#{self.full_name} \e[0m- Interactive mode, try 'exit' or 'help' for usage"
      end

      def banner(task, namespace = true, subcommand = false)
        "#{basename} #{task.formatted_usage(self, true, subcommand)}"
      end
    end

    desc 'repl', 'Interactive mode', :hide => true
    def repl
      $interactive = true
      Repl.start self
      $interactive = false
    end

    default_task :repl

    def help(task = nil, subcommand = false)
      unless task && subcommand
        say self.class.readme, :green
      end
      super(task, subcommand)
    end
  end
end
