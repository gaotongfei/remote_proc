require 'socket'

module RemoteProc
  class Server
    CRLF = '\r\n'

    def initialize(options)
      @server = TCPServer.new(options[:host], options[:port])
      @concurrency = options[:concurrency] || 25
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
          @client = @server.accept
          loop do
            request = @client.gets(CRLF)
            if request
              puts "request: #{request}"
              @client.write('response')
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

