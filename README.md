## Prometheus

Prometheus is a lightweight, modular framework built on [Thor](https://github.com/wycats/thor) to quickly create beautiful 
command-line interfaces for your gems. It provides a standardized layout with generators,
smart configuration, and an interactive console to work with your tasks.

### Getting Started

Install the gem and run it to enter interactive mode

    $ gem install prometheus

### Creating a new application

You can use the app generator to create a new application in your working directory.

    $ prometheus app new my_app
      create  my_app
      create  my_app/my_app.gemspec
      create  my_app/.gitignore
      create  my_app/Gemfile
      create  my_app/README.md
      create  my_app/Rakefile
      create  my_app/bin/my_app
      create  my_app/lib/my_app.rb
      create  my_app/lib/my_app/version.rb
      create  my_app/templates/default_config.yml
       chmod  my_app/bin/my_app
    $

### Automatic Configuration

The first time you run a Prometheus app, it will create a config file in your $HOME

    $ cd my_app
    $ bin/my_app
    Welcome to MyApp! You must be new, since you don't have a configuration file :-)
    Okay to create at /home/ldk/.my_app/config? (Y/N)
      create  /home/ldk/.my_app/config
    Prometheus Shell
      Project root [~/hack]> 

    Configuration saved!
    $

Your plugins can specify configurables that will be added to this file. Your app will
ensure that all the necessary values are set before running any tasks, even if you add
more later.

### Interactive Mode

If you do not pass a task to run, a Prometheus application will open an interactive 
console in the namespace you specify. You can use the application this way, jumping
into and out of namespaces as you please.

    $ prometheus 
    Prometheus - Interactive mode, try 'exit' or 'help' for usage
    Prometheus:commands> plugin
    Manage Plugins - Interactive mode, try 'exit' or 'help' for usage
    Prometheus:plugin> exit
    Prometheus:commands> exit
    $

You can also execute system or Ruby commands with the !! and !! operators.

    "! cmd" - Execute a system command
    "!! cmd" - Execute a line of Ruby
    "!!" - Toggle "debug mode", an interactive ruby REPL in the current process.

### Adding Plugins

Now that you have a barebones application, you can start implementing your own
functionality by way of plugins. Let's create one now.

    $ cd my_app
    $ prometheus plugin new say_hello
        create  lib/my_app/plugins/say_hello
        create  lib/my_app/plugins/say_hello/say_hello_commands.rb
        create  lib/my_app/plugins/say_hello/README
    New plugin adding to application at /home/ldk/Dropbox/home/hack/oss/prometheus/my_app/lib/my_app/plugins/say_hello
    Remember, this plugin will not be active until registered in your Prometheus::Commands subclass
    $

If you open up `lib/my_app/plugins/say_hello/say_hello_commands.rb`, you will see something like this

    module PrometheusApp
      class SayHello < Prometheus::Base

        full_name 'say_hello'
        namespace :say_hello
        readme File.read(File.expand_path('../README', __FILE__))

        desc 'new_task', 'A newly generated plugin task'
        def new_task
        end
      end
    end

Remove the boilerplate `new_task` and add your own greeting. Then jump out into `lib/my_app.rb` and register your new plugin.
      
      [...]

      class Commands < Prometheus::Commands
        readme File.read(File.expand_path('../../README.md', __FILE__))
        register SayHello, 'hello', 'hello', 'Display a greeting'
      end
    end

That's all there is to it. From here on out, it's just regular [Thor](https://github.com/wycats/thor).

### License

Released under the MIT License. See the LICENSE file for further details.
