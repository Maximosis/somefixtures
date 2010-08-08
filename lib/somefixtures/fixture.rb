require 'net/http'
module SomeFixtures
  class Fixture

    attr_accessor :format, :base_uri, :save_to, :login, :token
    
    def initialize fixture_info
      @format   = fixture_info[:format]
      @base_uri = fixture_info[:base_uri]
      @save_to  = fixture_info[:save_to]
      @login    = fixture_info[:login]
      @token    = fixture_info[:token]
      
      @fixtures = {}
    end
    
    def add_post(*args); add_fixture(:post,  *args) end
    def add_get(*args);  add_fixture(:get,   *args) end

    def make_fixtures!
      save query_fixtures
    end
    
    private
    def is_duplicate? name
      value = false
      @fixtures.each_key{ |key| value = true if key == name }
      print "WARNING: You have added a file named: \"#{name}\" already. Each filename must be unique!\n" if value
      return value
    end
    def add_fixture option, query, name, authenticate=false
      return true if is_duplicate? name
      @fixtures[name]  = { :option => option, :query => query, :authenticate => authenticate }
    end   
    def query_fixtures
      responses = []
      @fixtures.each_key do |fixture|
        if @fixtures[fixture][:option] == :post
          responses << ( post fixture )
        else
          responses << ( get fixture )
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
