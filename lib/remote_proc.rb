require 'socket'
require 'remote_proc/client'
require 'remote_proc/server'
require 'remote_proc/version'

module RemoteProc
  extend self
  class Error < StandardError; end

  def call(command, params)
    Client.new(options).call(command, params)
  end

  def options
    # default options
    { host: '127.0.0.1', port: 8099 }
  end
end
