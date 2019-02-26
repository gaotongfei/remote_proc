lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "remote_proc/version"

Gem::Specification.new do |spec|
  spec.name          = "remote_proc"
  spec.version       = RemoteProc::VERSION
  spec.authors       = ["gaotongfei"]
  spec.email         = ["me@gaotongfei.com"]

  spec.summary       = %q{A RPC library implemented in pure ruby}
  spec.description   = %q{A RPC library implemented in pure ruby}
  spec.homepage      = "https://github.com/gaotongfei/remote_proc"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry-byebug"
end
