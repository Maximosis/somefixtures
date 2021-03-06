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

Format:

	Fixture.new

Takes the following parameters:

	:save_to
	Location to save to. 
	
	:format
	Format expected to be returned. (Only used for adding a file extension at the moment.)
	
	:base_uri
	The base URI location to the API/Service. 

	:login
	:token
	Your authentication details. 
	
Example: 

	foo = Fixture.new( 
                    :save_to => "/Users/jbw/Desktop/", 
                    :format  => "json"
                    :base_uri => "http://github.com/api/v2/json",
                    :login => "jbw", 
                    :token => "account_password" )

The following shows some examples of adding fixtures to a data structure. 

Format:

	add_get

	
Takes the following: 

	:route <Hash>
	The API route.
	
	output_filename <String>
	The name you want your file to have. 
	
	authenticate <Boolean>
	Whether you need to authenticate with the server (Uses your :login, :token values).

Format:

	add_post
			
Takes the following: 
	
	:route <Hash>
	output_filename <String>
	authenticate <Boolean>
    (See add_get)
	
	:values <Hash>
	Values to post to the server. 


Example:
	
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

