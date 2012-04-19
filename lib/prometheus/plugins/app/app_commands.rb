module PrometheusApp
  class App < Prometheus::Base
    include Thor::Actions
    attr_accessor :name, :author_name, :author_email

    full_name 'Application Generator'
    namespace :app
    def self.source_root; TEMPLATES_PATH; end
    readme File.read(File.expand_path('../README', __FILE__))

    desc 'new', 'Generate a new Prometheus application'
    def new(name)
      @name = name
      @author_name = `git config --global --get user.name`.strip
      @author_email = `git config --global --get user.email`.strip
      directory 'app', @name
      chmod "#{@name}/bin/#{@name}", '+x'
    end
  end
end
