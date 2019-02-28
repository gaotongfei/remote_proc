require 'optparse'

module RemoteProc
  class CLI
    def self.parse_options(argv=ARGV)
      opts = {}

      @parser = OptionParser.new do |o|
        o.on '-c', '--concurrency CONCURRENCY', 'processor threads to use' do |arg|
          opts[:concurrency] = Integer(arg)
        end

        o.on '-t', '--timeout TIMEOUT', 'Shutdown timeout' do |arg|
          opts[:timeout] = Integer(arg)
        end

        o.on '-p', '--port PORT', 'Port RPC server listen to' do |arg|
          opts[:port] = Integer(arg)
        end

        o.on '-b', '--bind BIND', 'bind on host' do |arg|
          opts[:host] = arg
        end

        o.on '', '--commands-dir FOLDER', 'directory where commands file are stored' do |arg|
          opts[:commands_dir] = arg
        end
      end

      @parser.banner = 'remote_proc [options]'
      @parser.on_tail '-h', '--help', 'Show help' do
        puts @parser
        exit 1
      end

      @parser.parse!(argv)
      opts
    end
  end
end