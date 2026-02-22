# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_hl7_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_hl7_parser"
  spec.version       = SimpleHL7Parser::VERSION
  spec.authors       = ["Sufyan Adam"]
  spec.email         = ["sufyan.adam@gmail.com"]

  spec.summary       = %q{Simple, extensible HL7 message parser}
  spec.description   = %q{Dead Simple, extensible HL7 message parser}
  spec.homepage      = "https://github.com/sufyanadam/simple_hl7_parser"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.3.5"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "simplecov", "~> 0.22"
end
