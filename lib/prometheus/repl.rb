require_relative 'repl/command'

module Prometheus
  module Repl
    require 'readline'

    Command.define 'exit', 'q' do
      exit
    end

    Command.define 'system', '!' do |arg|
      system arg
    end

    Command.define 'debug', '!!' do |arg|
      if arg
        @context.say eval(arg), :cyan
      else
        @debug_mode = true
      end
    end

    class << self

      def start(context)
        @context = context
        @debug_mode = false
        setup_readline

        puts @context.class.repl_banner

        while buf = Readline.readline(prompt, true)
          line = buf.strip
          next if line.empty?
          begin
            if @debug_mode
              if line == '!!'
                @debug_mode = false
              else
                @context.say eval(line), :cyan
              end
            else
              execute line
            end
          rescue SystemExit
            raise
          rescue Exception => e
            @context.say "#{e.message}\n#{e.backtrace.join("\n")}", :red
          end
          setup_readline
        end
      end

      def prompt
        ns = @context.class.namespace.split(':').last
        ns = 'debug' if @debug_mode
        "\e[34m#{PROMPT}:\e[35m#{ns}\e[0m>\e "
      end

      def setup_readline
        Readline.basic_word_break_characters = ""
        Readline.completion_proc = lambda do |word|
          (
            @context.class.tasks.keys.map { |name| name } +
            Command.command_names.map { |name| name.to_s } +
            ['help']
          ).grep(/#{Regexp.quote(word)}/)
        end
      end

      def execute(line)
        if command = Command.find(line)
          arg = line.split(/\s+/, 2)[1] rescue nil
          command.call(arg)
        else
          invoke(line.strip)
        end
      end

      def invoke(line)
        start = Time.now

        name, *args = line.split(/\s+/)
        pid = fork do
          args.each do |arg|
            env, value = arg.split('=')
            next unless env && !env.empty? && value && !value.empty?
            ENV[env] = value
          end
          begin
            @context.invoke(name, args)
          rescue Exception => e
            raise unless e.to_s == "undefined method `<=' for nil:NilClass"
            @context.say "I don't know that task, try 'help' to see what's available", :red
          end
        end
        Process.waitpid(pid)
      end

    end
  end

end
