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
    
    def add option, query, name, authenticate=false
      @fixtures.each_key { |key| print name == key ? "You have added \"#{key}\" for a file name already. Each filename must be unique!\n" : nil  }
      @fixtures[name] = { :option => option, :query => query, :authenticate => authenticate }
    end
    

    def make_fixtures!
      save (query)
    end
    
    def add_post(*args); add(:post, *args) end
    def add_get(*args); add(:get, *args) end
    
    private
    
    def query
      responses = []
      @fixtures.each_key do |name|
        if @fixtures[name][:option] == :post
          responses << (post name)
        else
          responses << (get name)
        end
      end
      responses
    end
    
    def get name
      self.class.get( @base_uri + @fixtures[name][:query], :query => (authenticated? name) )
    end
    
    def post name
      self.class.post( @base_uri + @fixtures[name][:query], :query => (authenticated? name) )
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
