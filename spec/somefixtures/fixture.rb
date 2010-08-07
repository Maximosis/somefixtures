module SomeFixtures
  describe Fixture, " that requires authentication" do
    include Helper
    before(:each){ @valid = Fixture.new(Helper.valid)}
    
    context "when posting" do
      context "without parameters" do
        it "should return successfully" do
          stub_post("/user/follow/joecolly", "follow.json")
          @valid.add_post({ :route => "/user/follow/joecolly" }, "follow", true)
          @valid.make_fixtures!['joecolly'].should == "joecolly"
        end
      end
      context "with parameters" do
        it "should return repo name sucessfully" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json")
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[name]=emacs"},"repo_update_name", true)
          @valid.make_fixtures!["name:emacs"].should == "name:emacs"
        end
        it "should return repo description" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json")
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[description]=My Emacs configs"}, "repo_update_name", true)
          @valid.make_fixtures!["description:My Emacs configs"].should == "description:My Emacs configs"
        end
        
        it "should return repo has_issues true" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json")
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[has_issues]=true"}, "repo_update_name", true)
          @valid.make_fixtures!["has_issues:true"].should == "has_issues:true"
        end
        it "should return repo homepage" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json")
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[homepage]="""}, "repo_update_name", true)
          @valid.make_fixtures!["homepage:"""].should == "homepage:"""
        end
        it "should return repo has_downloads true" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json")
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[has_downloads]=true"}, "repo_update_name", true)
          @valid.make_fixtures!["has_downloads:true"].should == "has_downloads:true" 
        end
        it "should return repo has_wiki true" do
          stub_post("/repos/show/jbw/emacs", "repo_update.json")
          @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[has_wiki]=true"}, "repo_update_name", true)
          @valid.make_fixtures!["has_wiki:true"].should == "has_wiki:true" 
        end
      end
    end
  end
end
