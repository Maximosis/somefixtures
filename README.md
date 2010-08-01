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

Create a fixture object with the necessary details. The example given
is from github, if you need to authenticate, supply your github username and
password.  

	foo = Fixture.new( 
                    :save_to => "/Users/jbw/Desktop/", 
                    :format  => "json"
                    :base_uri => "http://github.com/api/v2/json",
                    :login => "jbw", 
                    :token => "account_password" )

You can supply the :get or :post option to add, otherwise use add\_get or
add\_post. 

	foo.add(:get, "/user/search/jbw", "search")
	foo.add_get("/user/search/jbw", "search")

	foo.add_get("/user/show/jbw", "show_unauthenticated")
	foo.add_get("/user/show", "show_authenticated", true)
	foo.add_get("/user/show/jbw/followers", "followers")

	foo.add(:post, "/user/follow/jbw", "follow", true) 
	foo.add_post("/user/follow/jbw", "follow", true)

Once all the locations are added you can execute the following command to fetch
the fixtures:

	foo.make_fixtures!
	
Licence
-------
MIT

TODO
----
* Make more generic
* Documentation

