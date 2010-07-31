SomeFixtures
============

SomeFixtures was created to make local fixtures (sample data) for stubs by 
specifying a fixture location which is then downloaded and saved to disk.

It was basically made to automate the task a little bit for me and deep down is
nothing more than a downward file transfer tool. 

Install
-------
	gem install somefixtures

Usage
-----
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
	
Licence
-------
MIT

TODO
----
* Make more generic
* Documentation
