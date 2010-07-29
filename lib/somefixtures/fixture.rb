require 'HTTParty'

module SomeFixtures
  class Fixture
    include HTTParty
    format @format
        
    def initialize fixture_info
      @format   = fixture_info[:format]
      @base_uri = fixture_info[:base_uri]
      @save_to  = fixture_info[:save_to]
      @fixtures = {}
    end

    def add query, name
      @fixtures.each_key { |key| print name == key ? "You have added \"#{key}\" for a file name already. Each filename must be unique!\n" : nil }
      @fixtures[name] = @base_uri + query
    end

    def make_fixtures!
      save (get @fixtures)
    end

    private
    def get fixtures
      responses = []
      @fixtures.each_value{ |key| responses << self.class.get(key) }
      responses
    end

    def save fixtures
      name = @fixtures.keys
      fixtures.each do |f|
        File.new(@save_to + name.first + "." + @format, "w").puts f
        name.shift
      end  
    end
    
  end
end
