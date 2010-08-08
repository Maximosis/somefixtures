require SomeFixtures

class T 
  include SomeFixtures
  
  foo = Fixture.new( 
                    :save_to => "/Users/jbw/Desktop/", 
                    :format  => "json",
                    :base_uri => "http://github.com/api/v2/json",
                    :login => "username", 
                    :token => "password" )

  foo.add_get( { :route => "/user/show/jbw" }, "showw")

  foo.add_post({ :route => "/user/follow/jbw" }, "follow", true)
  
  foo.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[description]=My Emacs configs" },"repo_update_description", true )

  foo.make_fixtures!
  
end

T.new
