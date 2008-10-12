require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IncomingsController do
 
  describe "with plural actions" do

    it "should get index" do
      get :index
      response.should be_success
    end

  end

  describe " with singular actions" do

    before(:each) do
      @incoming = mock("incoming")

      Incoming.stub!(:find).and_return(@incoming)

      @incoming.stub!(:id).and_return(10)
      @incoming.stub!(:save).and_return(true)
      @incoming.stub!(:destroy).and_return(@incoming)
    end

    it "should get show" do
      get :show, :id => 10
      response.should be_success
    end

    it "should get new" do
      get :new
      response.should be_success
    end

    it "should destroy incoming" do
      delete :destroy, :id => 10
      response.should be_redirect
    end

    it "should create incoming" do
      Incoming.should_receive(:new).with( {"detail" => "incoming me"} ).and_return(@incoming)

      post :create, :incoming => {:detail => "incoming me"}
      #TODO: How to get this redirect with make reaccountful
      #response.should redirect_to(:action => :index)
      response.should be_redirect
    end

    it "should update incoming" do
      @incoming.should_receive(:update_attributes).with( {"detail" => "incoming me"} ).and_return(@incoming)

      put :update, {:id => 10, :incoming => {:detail => "incoming me"}}
      #TODO: How to get this redirect with make reaccountful
      #response.should redirect_to(:action => :show, :id => 10)
      response.should be_redirect
    end
  end
end
