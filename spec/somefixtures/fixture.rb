module SomeFixtures
  include Helper

  describe Fixture, " when adding a new fixture" do
  describe Fixture  do
    before(:each){ @valid = Fixture.new(Helper.valid)}
    context "when adding a fixture with the same name twice" do
    context "when adding a fixture with an existing name" do
      it "should not allow you to create a file with the same name twice" do
        @valid.add_get({ :route => "/user/show/joecolly"}, "show")
        @valid.add_get({ :route => "/user/show/jbw"}, "show").should == true
      end
    end
  end
  describe Fixture, " that does not require authentication " do
    before(:each){ @valid = Fixture.new(Helper.valid)}
    context "when creating a fixture" do
      it "should return the fixture information" do
        @valid.format.should   == "json"
        @valid.base_uri.should == "http://github.com/api/v2/json"
        @valid.save_to.should  == "/Users/jbw/Desktop/"
      end
    end      
    context "when getting" do
      context "without paramaters" do
        it "should return a users information" do
          stub_get("/user/show/jbw", "show_unauthenticated.json", nil, false)
          @valid.add_get({ :route => "/user/show/jbw"}, "show_unauthenticated")
          @valid.make_fixtures!["name:Jason Watson"].should == "name:Jason Watson"
        end
      end
    end
  end
  describe Fixture, " that requires authentication" do
    before(:each){ @valid = Fixture.new(Helper.valid)}
    context "when creating a fixture" do
      it "should return the fixture information" do
        @valid.format.should   == "json"
        @valid.base_uri.should == "http://github.com/api/v2/json"
        @valid.save_to.should  == "/Users/jbw/Desktop/"
        
        @valid.login == "jbw"
        @valid.token == "pass"
      end      
    end
    context "when getting" do
      context "without parameters" do
        it "should return " do
          stub_get("/user/show/jbw", "show_authenticated.json", nil, true)
          @valid.add_get({ :route => "/user/show/jbw"}, "show_authenticated", true)
          @valid.make_fixtures!["plan:{name:free"].should == "plan:{name:free"
          
        end
      end
    end
    context "when posting" do
      context "without parameters" do
        it "should return successfully" do
          stub_post("/user/follow/joecolly", "follow.json", nil, true)
          @valid.add_post({ :route => "/user/follow/joecolly" }, "follow", true)
          @valid.make_fixtures!['joecolly'].should == "joecolly"
        end
      end
      context "with multiple parameters" do
        it "should return all parameters" do
          stub_post("repos/show/jbw/emacs", "repo_update_all.json", nil, true)
          @valid.add_post( { :route => "repos/show/jbw/emacs", :values => "values[name]=Emacs, values[homepage]=http://emacs.jbw.cc"}, "repo_update_all", true)
          @valid.make_fixtures!["name:Emacs"].should == "name:Emacs"
          @valid.make_fixtures!["homepage:http://emacs.jbw.cc"].should == "homepage:http://emacs.jbw.cc"
        end
      end
      
      context "with parameters" do
        it "should return repo name sucessfully" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json", nil, true)
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[name]=emacs"},"repo_update_name", true)
          @valid.make_fixtures!["name:emacs"].should == "name:emacs"
        end
        it "should return repo description" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json", nil, true)
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[description]=My Emacs configs"}, "repo_update_name", true)
          @valid.make_fixtures!["description:My Emacs configs"].should == "description:My Emacs configs"
        end
        it "should return repo has_issues true" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json", nil, true)
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[has_issues]=true"}, "repo_update_name", true)
          @valid.make_fixtures!["has_issues:true"].should == "has_issues:true"
        end
        it "should return repo homepage" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json", nil, true)
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[homepage]="""}, "repo_update_name", true)
          @valid.make_fixtures!["homepage:"""].should == "homepage:"""
        end
        it "should return repo has_downloads true" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json", nil, true)
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[has_downloads]=true"}, "repo_update_name", true)
          @valid.make_fixtures!["has_downloads:true"].should == "has_downloads:true" 
        end
        it "should return repo has_wiki true" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json", nil, true)
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[has_wiki]=true"}, "repo_update_name", true)
          @valid.make_fixtures!["has_wiki:true"].should == "has_wiki:true" 
        end
      end
    end
  end
end
