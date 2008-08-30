require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
#TODO - i'd like to review this and consider:
# * What would make a meaningful general purpose rspec controller test
# * What needs to be taken across the make_resourcefuls own test when 
# considering testing a make resourceful controller

describe FlushesController do
 
  describe "with plural actions" do

    it "should get index" do
      get :index
      response.should be_success
    end

  end

  describe " with singular actions" do

    before(:each) do
      @flush = mock("flush")

      Flush.stub!(:find).and_return(@flush)

      @flush.stub!(:id).and_return(10)
      @flush.stub!(:save).and_return(true)
      @flush.stub!(:destroy).and_return(@flush)
    end

    it "should get show" do
      get :show, :id => 10
      response.should be_success
    end

    it "should get new" do
      get :new
      response.should be_success
    end

    it "should destroy flush" do
      delete :destroy, :id => 10
      response.should be_redirect
    end

    it "should create flush" do
      Flush.should_receive(:new).with( {"detail" => "flush me"} ).and_return(@flush)

      post :create, :flush => {:detail => "flush me"}
      #TODO: How to get this redirect with make resourceful
      #response.should redirect_to(:action => :index)
      response.should be_redirect
    end

    it "should update flush" do
      @flush.should_receive(:update_attributes).with( {"detail" => "flush me"} ).and_return(@flush)

      put :update, {:id => 10, :flush => {:detail => "flush me"}}
      #TODO: How to get this redirect with make resourceful
      #response.should redirect_to(:action => :show, :id => 10)
      response.should be_redirect
    end
  end
end
