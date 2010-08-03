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
        context "with parameters" do
          it "should return sucessfully" do
            stub_post("/repos/show/jbw/emacs", "repo_update.json")
            @valid.add_post({ :route => "/repos/show/jbw/emacs", :values => "values[name]=emacs"},
                            "repo_update_name", true)
            @valid.make_fixtures!['emacs'].should == "emacs"
          end
        end
      end
    end
  end
end
