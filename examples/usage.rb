require 'SomeFixtures'

class T 
  include SomeFixtures
  
  foo = Fixture.new( 
                    :save_to => "/Users/jbw/Desktop/", 
                    :format => "json", 
                    :base_uri => "http://github.com/api/v2/json",
                    :login => "jbw", 
                    :token => "WOOBWOOB" )

  foo.add(:get, "/user/search/jbw", "search")
  foo.add_get("/user/search/jbw", "search")
  
  foo.add_get("/user/show/jbw", "show_unauthenticated")
  foo.add_get("/user/show/jbw", "show_authenticated", true)
  foo.add_get("/user/show/jbw/followers", "followers")

  foo.add(:post, "/user/follow/jbw", "follow", true) 
  foo.add_post("/user/follow/jbw", "follow", true)

  foo.make_fixtures!
  
end

T.new
