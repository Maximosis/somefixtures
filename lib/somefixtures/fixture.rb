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
          puts "---- Posting started"
          responses << (post name)
          puts "++++ Posting done."
        else
          puts "---- Getting started"
          responses << (get name)
          puts "++++ Getting done."
        end
      end
      responses
    end
     
    def authenticated? name
      @authenticate = @fixtures[name][:authenticate]; 
      auth_params
    end

    def get name
      Net::HTTP.start((split_uri @base_uri)[1]) do |http|     
        req = Net::HTTP::Get.new((split_uri @base_uri)[2] + @fixtures[name][:query])
        if @fixtures[name][:authenticate] == true
          req.basic_auth (authenticated? name)[:login], (authenticated? name)[:token]
        else
          req.basic_auth @login, @token
        end        
        response = http.request(req)
        response.body 
      end
    end
    
    def post name
      puts "\t-- Posting #{name} started"
      Net::HTTP.start((split_uri @base_uri)[1]) do |http| 
        req = Net::HTTP::Post.new((split_uri @base_uri)[2] + @fixtures[name][:query][:route])
        req.body = @fixtures[name][:query][:values]
        req.basic_auth @login, @token
        response = http.request(req)
        response.body
      end
      puts "\t++ Posting #{name} done."
    end
    
    def split_uri uri
      if uri.match(/(http:\/\/)([a-zA-Z.]+)([a-zA-Z\d\/]+)/)
        [$1, $2, $3]
      end
    end
    
    def save fixtures
      name = @fixtures.keys
      puts "---- Saving fixtures started"
      fixtures.each do |f|
        puts "\t-- Saving #{name.first} starting..."
        File.new(@save_to + name.first + "." + @format, "w").puts f
        name.shift
        puts "\t++ Saving #{name.first} done."
      end
      puts '++++ Saving fixtures done'
    end

    def auth_params 
      if @authenticate; (@login.nil? ? {} : { :login => @login, :token => @token }); end
    end

  end
end
