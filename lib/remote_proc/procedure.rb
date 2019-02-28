module RemoteProc
  class Procedure
    # @param request [Hash]
    #   * :command (String)
    #   * :params (Hash)
    # For example, {:command=>"user.fetch_user_info", :params=>{:user_key=>"aabbcc"}}
    def self.call(request)
      constantize_command(request['command']).call(request['params'])
    end

    private

    def self.constantize_command(command_string)
      Object.const_get command_string.split(".").map {|s| s.split('_').map(&:capitalize).join }.join("::")
    end
  end
end