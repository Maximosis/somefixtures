require 'net/http'
module SomeFixtures
  class Fixture
    
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
      save query 
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
     
    def get fixture
      Net::HTTP.start(get_uri[:location]) do |http|     
        request = Net::HTTP::Get.new(get_uri[:route] + @fixtures[fixture][:query][:route])
        authenticate_if_values_given fixture, request
        response = http.request(request)
        return response.body 
      end
    end
    
    def post fixture
      Net::HTTP.start(get_uri[:location]) do |http| 
        request = Net::HTTP::Post.new(get_uri[:route] + @fixtures[fixture][:query][:route])
        request.body = @fixtures[fixture][:query][:values]
        authenticate_if_values_given fixture, request
        response = http.request(request)
        return response.body
      end
    end
    
    def get_uri 
      if @base_uri.match(/(http:\/\/)([a-zA-Z.]+)([a-zA-Z\d\/]+)/)
        {:location => $2, :route => $3}
      end
    end
    
    def save fixtures
      name = @fixtures.keys
      fixtures.each do |f|
        File.new(@save_to + name.first + "." + @format, "w").puts f
        name.shift
        return f.gsub("\"", "")
      end
    end

    def auth_params 
      if @authenticate; (@login.nil? ? {} : { :login => @login, :token => @token }); end
    end

    def authenticated? name
      @authenticate = @fixtures[name][:authenticate];
      auth_params
    end

    def authenticate_if_values_given fixture, request
      if @fixtures[fixture][:authenticate] == true
        request.basic_auth (authenticated? fixture)[:login], (authenticated? fixture)[:token]
      end
    end 
  end
end
