require 'HTTParty'

module SomeFixtures
  class Fixture
    include HTTParty
    
    format @format
    
    attr_accessor :locations  
    def initialize details = { }
   
      @location = details[:location]
      @format   = details[:format]
      @base_uri = details[:base_uri]
      @locations  = [] 
      @name = []
      
    end
    
    # Sometimes you will need to be authenticated to :get the fixtures you need. 
    def auth auth_params = {}
      
      @login = auth[:login]
      @token = auth[:token]
      
    end
    
    def add query, name
      @name << name
      fixture = @base_uri + query
      @locations << fixture
      
    end
    
    def make_fixtures! 
      
      fixtures = get @locations
      save fixtures
      
    end
    
    private
    
    def get fixtures
      
      response = []
      fixtures.each do |f|
        response << self.class.get(f)
      end
      
      response
      
    end
    
    def save fixtures
      i = 0
      fixtures.each do |f|
        new_fixture = File.new(@location + @name[i] + "." + @format, "w")
        new_fixture.puts f
        i += 1
      end
      
    end 
    
  end
end