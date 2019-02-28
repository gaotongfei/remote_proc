require 'socket'
require_relative '../remote_proc/logging'
require_relative '../remote_proc/procedure'
require 'json'

module RemoteProc
  class Server
    include ::RemoteProc::Logging
    CRLF = "\r\n"

    attr_reader :logger
    def initialize(options)
      @options = options
      @server = TCPServer.new(@options[:host], @options[:port])
      @concurrency = @options[:concurrency] || 25
      @logger = set_basic_logger
      load_commands
    end

    def run
      threads = ThreadGroup.new

      @concurrency.times do
        threads.add spawn_thread
      end

      sleep
    end

    private

    def load_commands
      Dir[File.join(@options[:commands_dir], '*.rb')].each do |file|
        begin
          require file
        rescue LoadError => e
          logger.error "Can not require #{file}, you may want to check it. \n#{e.backtrace}"
        end
      end
    end

    def spawn_thread
      Thread.new do
        loop do
          @client = @server.accept
          loop do
            request = @client.gets
            if request
              params = JSON.parse(request.split(CRLF).first)
              logger.info "request params is: #{params}"
              response = RemoteProc::Procedure.call(params)
              @client.write(response)
            else
              @client.close
              break
            end
          end
        end
      end
    end
  end
end

