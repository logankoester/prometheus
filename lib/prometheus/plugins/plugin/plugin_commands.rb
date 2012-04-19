module PrometheusApp
  class Plugin < Prometheus::Base
    include Thor::Actions
    attr_accessor :name

    full_name 'Manage Plugins'
    namespace :plugin
    def self.source_root; TEMPLATES_PATH; end
    readme File.read(File.expand_path('../README', __FILE__))

    desc 'new', 'Add a plugin to the application in the working directory'
    def new(name)
      @name = name
      plugin_dirs = Dir[File.join(Dir.pwd, 'lib', '**', 'plugins')]
      unless plugin_dirs.empty?
        plugin_dir = File.expand_path(File.join(plugin_dirs.first, @name))
        directory 'plugin', plugin_dir
        say "New plugin adding to application at #{plugin_dir}", :green
        say "Remember, this plugin will not be active until registered in your Prometheus::Commands subclass", :yellow
      else
        say "#{Dir.pwd} does not appear to be a Prometheus application", :red
      end
    end
  end
end
