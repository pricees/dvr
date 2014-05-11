# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dvr/version'

Gem::Specification.new do |spec|
  spec.name          = "dvr"
  spec.version       = Dvr::VERSION
  spec.authors       = ["Edward Price"]
  spec.email         = ["ted.price@gmail.com"]
  spec.summary       = %q{DVR domain}
  spec.description   = %q{DVR domain }
  spec.homepage      = "https://github.com/pricees/dvr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

end
