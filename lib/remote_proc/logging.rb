require 'logger'

module RemoteProc
  module Logging
    def set_basic_logger
      @logger = ::Logger.new(STDOUT)
      @logger.level = ::Logger::INFO
      @logger
    end
  end
end