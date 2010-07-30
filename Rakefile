require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name        = 'somefixtures'
  s.version     = '0.0.1'
  s.date        = '2010-07-30'
  s.description = "Testing fixture automator. Easies the pain of getting sample data for testing."
  s.summary     = s.description
  
  s.authors     = ["Jason Watson"]
  s.email       = "jbw@bw.cc"
  
  s.files = %w[
    CHANGELOG	
    LICENCE		
    README.markdown		
    Rakefile	
    VERSION
    docs/
    examples/
    lib/somefixtures.rb
    lib/somefixtures/fixture.rb
    test/
    somefixtures.gemspec
  ]
  s.add_development_dependency 'HTTParty'
  s.homepage = "http://github.com/jbw/somefixtures/"
  s.require_paths = %w[lib]
  s.rubyforge_project = 'somefixtures'
  
end

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end