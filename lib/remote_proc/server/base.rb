module RemoteProc
  module Server
    class Base
      def load_commands
        Dir[File.join(@options[:commands_dir], '*.rb')].each do |file|
          begin
            require file
          rescue LoadError => e
            logger.error "Can not require #{file}, you may want to check it. \n#{e.backtrace}"
          end
        end
      end
    end
  end
end