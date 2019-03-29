require 'socket'
require 'logger'
require 'remote_proc/client'
require 'remote_proc/server/multi_threaded'
require 'remote_proc/version'
require 'remote_proc/procedure'
require 'remote_proc/logging'

module RemoteProc
  extend self
  class Error < StandardError; end

  def call(command, params)
    Client.new(options).call(command, params)
  end

  # default options
  def options
    { host: '127.0.0.1', port: 8099 }
  end
end
