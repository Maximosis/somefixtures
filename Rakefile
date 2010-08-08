require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name        = 'somefixtures'
  s.version     = '0.2.0'
  s.date        = '2010-08-08'
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
  s.homepage = "http://github.com/jbw/somefixtures/"
  s.require_paths = %w[lib]
  s.rubyforge_project = 'somefixtures'
end

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end