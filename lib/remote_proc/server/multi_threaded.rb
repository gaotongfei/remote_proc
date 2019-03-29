require 'socket'
require_relative '../../remote_proc/logging'
require_relative  '../../remote_proc/procedure'
require_relative '../../remote_proc/server/base'

require 'json'
require 'pry-byebug'

module RemoteProc
  module Server
    class MultiThreaded < Base
      include ::RemoteProc::Logging
      CRLF = "\r\n"

      attr_reader :logger
      def initialize(options)
        @options = options
        @server = TCPServer.new(@options[:host], @options[:port])
        @concurrency = @options[:concurrency] || 25
        @logger = set_basic_logger
        @mutex = Mutex.new
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

      def spawn_thread
        Thread.new do
          loop do
            @mutex.synchronize {
              @conn = @server.accept
              @request = @conn.gets
              if @request
                params = JSON.parse(@request.split(CRLF).first)
                logger.info "request params is: #{params}"
                response = RemoteProc::Procedure.call(params)

                @conn.write(response)
              end
              @conn.close
            }
          end
        end
      end
    end
  end
end

