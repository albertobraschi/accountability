require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
#TODO - i'd like to review this and consider:
# * What would make a meaningful general purpose rspec controller test
# * What needs to be taken across the make_reaccountfuls own test when 
# considering testing a make reaccountful controller

describe OutgoingsController do
 
  describe "with plural actions" do

    it "should get index" do
      get :index
      response.should be_success
    end

  end

  describe " with singular actions" do

    before(:each) do
      @outgoing = mock("outgoing")

      Outgoing.stub!(:find).and_return(@outgoing)

      @outgoing.stub!(:id).and_return(10)
      @outgoing.stub!(:save).and_return(true)
      @outgoing.stub!(:destroy).and_return(@outgoing)
    end

    it "should get show" do
      get :show, :id => 10
      response.should be_success
    end

    it "should get new" do
      get :new
      response.should be_success
    end

    it "should destroy outgoing" do
      delete :destroy, :id => 10
      response.should be_redirect
    end

    it "should create outgoing" do
      Outgoing.should_receive(:new).with( {"detail" => "outgoing me"} ).and_return(@outgoing)

      post :create, :outgoing => {:detail => "outgoing me"}
      #TODO: How to get this redirect with make reaccountful
      #response.should redirect_to(:action => :index)
      response.should be_redirect
    end

    it "should update outgoing" do
      @outgoing.should_receive(:update_attributes).with( {"detail" => "outgoing me"} ).and_return(@outgoing)

      put :update, {:id => 10, :outgoing => {:detail => "outgoing me"}}
      #TODO: How to get this redirect with make reaccountful
      #response.should redirect_to(:action => :show, :id => 10)
      response.should be_redirect
    end
  end
end
