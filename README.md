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

The following shows some examples of adding fixtures to a data structure. 

    foo.add_get( { :route => "/user/show/jbw" }, "show")                                                                                                       
                                                                                                                                                              
    foo.add_post({ :route => "/user/follow/jbw" }, "follow", true)                                                                                              
                                                                                                                                                              
    foo.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[description]=My Emacs configs" },"repo_update_description", true )                     
                                                                                                                                                              

Once all the routes are added you can execute the following command to fetch
the fixtures:

	foo.make_fixtures!
	
Licence
-------
MIT

TODO
----
* Documentation

