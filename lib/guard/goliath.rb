require 'guard'
require 'guard/goliath/runner'
require 'rbconfig'

module Guard
  class Goliath < Plugin
    attr_reader :options, :runner

    DEFAULT_OPTIONS = {
        port: 9000,
        environment: 'development',
        start_on_start: true,
        force_run: false,
        timeout: 20,
        app_file: 'app.rb',
        supress_output: false
      }

    def initialize(options = {})
      super
      @options = DEFAULT_OPTIONS.merge(options)
      @runner = ::Guard::GoliathRunner.new(@options)
    end

    def start
      UI.info "Guard::Goliath will now restart your app on port #{options[:port]} using #{options[:environment]} environment."
      reload if options[:start_on_start]
    end

    def reload
      UI.info 'Restarting App...'
      Notifier.notify("App restarting on port #{options[:port]} in #{options[:environment]} environment...", title: 'Restarting App...', image: :pending)
      if runner.restart
        UI.info "App restarted, pid #{runner.pid}"
        Notifier.notify("App restarted on port #{options[:port]}.", title: 'App restarted!', image: :success)
      else
        UI.info 'App NOT restarted, check your log files.'
        Notifier.notify('App NOT restarted, check your log files.', title: 'App NOT restarted!', image: :failed)
      end
    end

    def stop
      Notifier.notify('Until next time...', title: 'App shutting down.', image: :pending)
      runner.stop
    end

    def run_on_changes(paths)
      reload
    end
  end
end
