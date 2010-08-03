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
    end
  end
end
