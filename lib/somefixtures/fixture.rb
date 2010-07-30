require 'cgi'
require 'HTTParty'

module SomeFixtures
  class Fixture
    include HTTParty
    format @format
    
    def initialize fixture_info
      @format   = fixture_info[:format]
      @base_uri = fixture_info[:base_uri]
      @save_to  = fixture_info[:save_to]
      @login    = fixture_info[:login]
      @token    = fixture_info[:token]
      
      @fixtures = {}
    end
    
    def add query, name, authenticate = false
      @fixtures.each_key { |key| print name == key ? "You have added \"#{key}\" for a file name already. Each filename must be unique!\n" : nil  }
      @fixtures[name] = { :query => query, :authenticate => authenticate }
    end

    def make_fixtures!
      save (get @fixtures)
    end

    private
    def get fixtures
      responses = []

      @fixtures.each_key do |name|
        responses << self.class.get( @base_uri + @fixtures[name][:query], :query => (authenticated? name) )
      end

      responses
    end

    def authenticated? name
      @authenticate = @fixtures[name][:authenticate]; 
      auth_params
    end

    def save fixtures
      name = @fixtures.keys

      fixtures.each do |f|
        File.new(@save_to + name.first + "." + @format, "w").puts f
        name.shift
      end  
    end

    def auth_params 
      if @authenticate; (@login.nil? ? {} : { :login => @login, :token => @token }); end
    end

  end
end
