
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require "job_minder/version"

require_relative 'lib/job_minder'

Gem::Specification.new do |spec|
  spec.name          = "jobminder"
  spec.version       = JobMinder::VERSION
  spec.authors       = ["David Kelly"]
  spec.email         = ["david@futuresbright.com"]

  spec.summary       = %q{A job minder}
  spec.description   = %q{A job minder}
  spec.homepage      = 'https://github.com/opensourceame/jobminder'
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = 'https://github.com/opensourceame/jobminder'
    spec.metadata["changelog_uri"] = 'https://github.com/opensourceame/jobminder/CHANGELOG.md'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "sequel"
  # spec.add_development_dependency "sequel_sqlite3"
  spec.add_development_dependency "factory_bot"
  spec.add_development_dependency "pry"
end
