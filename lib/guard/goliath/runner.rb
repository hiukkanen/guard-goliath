require 'fileutils'
require 'timeout'
require 'spoon'

module Guard
  class GoliathRunner
    attr_reader :options, :pid

    def initialize(options)
      @options = options
    end

    def start
      kill_unmanaged_pid! if options[:force_run]
      @pid = run_rack_command!
      true
    end

    def stop
      # Rely on kill_unmanaged_pid if there's no pid
      return true unless @pid

      exitstatus = kill(@pid)
      @pid = nil
      if exitstatus && exitstatus != 0
        UI.info "Ruby exited with non-zero exit status (#{exitstatus}) whilst trying to stop."
        return false
      end

      true
    end

    def restart
      stop && start
    end

    private

    def build_rack_command
      command = %w{ruby}
      command.push(
        options[:app_file],
        '--environment', options[:environment].to_s,
        '--port', options[:port].to_s
      )
      command << '--daemonize' if options[:daemon]
      command << '-sv' unless options[:supress_output]
      command.push('--config', options[:config]) if options[:config]

      command
    end

    def kill(pid, force = false)
      result = -1

      UI.debug("Trying to kill app (PID #{pid})...")
      unless force
        Process.kill('INT', pid)
        begin
          Timeout.timeout(options[:timeout]) do
            _, status = Process.wait2(pid)
            result = status.exitstatus
            UI.debug("Killed App (Exit status: #{result})")
          end
        rescue Timeout::Error
          UI.debug("Couldn't kill App with INT, switching to TERM")
          force = true
        end
      end

      Process.kill('TERM', pid) if force

      result
    end

    def run_rack_command!
      command = build_rack_command
      UI.debug("Running App with command: #{command.inspect}")
      spawn(*command)
    end

    def spawn(* args)
      Spoon.spawnp(* args)
    end

    def kill_unmanaged_pid!
      pid = unmanaged_pid
      kill(pid, true) if pid
    end

    def unmanaged_pid
      %x{lsof -n -i TCP:#{options[:port]}}.each_line do |line|
        return line.split("\s")[1].to_i if line["*:#{options[:port]} "]
      end
      nil
    end
  end
end
