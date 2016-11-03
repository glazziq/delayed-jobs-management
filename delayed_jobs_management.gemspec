$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "delayed_jobs_management/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "delayed_jobs_management"
  s.version     = DelayedJobsManagement::VERSION
  s.authors     = ["PiYa Nattawud"]
  s.email       = ["piya@glazziq.com"]
  s.homepage    = ""
  s.summary     = "delayed jobs management"
  s.description = "delayed jobs management"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.2.0"
  s.add_dependency "delayed_job"

end
