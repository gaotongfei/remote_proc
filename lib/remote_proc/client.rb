require 'socket'

module RemoteProc
  class Client
    def initialize(options)
      @client = TCPSocket.new(options[:host], options[:port])
    end

    def call(command, params)
      @client.write({ command: command, params: params })
      @client.write("\r\n")
      @client.close_write
      puts @client.read
    end
  end
end

