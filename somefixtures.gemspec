Gem::Specification.new do |s|
  s.name        = 'somefixtures'
  s.version     = '0.1.0'
  s.date        = '2010-07-30'
  s.description = "Testing fixture automator. Easies the pain of getting sample data for testing."
  s.summary     = s.description
  
  s.authors     = ["Jason Watson"]
  s.email       = "jbw@bw.cc"
  
  s.files = %w[
    LICENCE		
    README.md		
    Rakefile	
    VERSION
    docs/
    examples/
    lib/somefixtures.rb
    lib/somefixtures/fixture.rb
    spec/
    somefixtures.gemspec
  ]
  s.homepage = "http://github.com/jbw/somefixtures/"
  s.require_paths = %w[lib]
  s.rubyforge_project = 'somefixtures'
  s.add_dependency('httparty', '>= 0.6.1')
end