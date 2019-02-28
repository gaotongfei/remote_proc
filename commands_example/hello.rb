class Hello
  # @param params [Hash]
  # @option :name [String]
  # @return String
  def self.call(params)
    return "Hello, #{params['name']}"
  end
end