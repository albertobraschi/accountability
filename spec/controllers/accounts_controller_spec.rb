require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AccountsController do
  #integrate_views 
  describe "with plural actions" do

    it "should get index" do
      get :index
      response.should be_success
    end

  end

  describe " with singular actions" do

    before(:each) do
      @account = mock("account")

      Account.stub!(:find).and_return(@account)

      @account.stub!(:id).and_return(10)
      @account.stub!(:save).and_return(true)
      @account.stub!(:destroy!).and_return(@account)
    end

    it "should get show" do
      get :show, :id => 10
      response.should be_success
    end

    it "should get new" do
      get :new
      response.should be_success
    end

    it "should destroy account" do
      delete :destroy, :id => 10
      response.should be_redirect
    end

    it "should create account" do
      Account.should_receive(:create).with( {"title" => "my account"} ).and_return(@account)

      post :create, :account => {:title => "my account"}
      response.should redirect_to(:action => :index)
    end

    it "should update account" do
      @account.should_receive(:update_attributes).with( {"title" => "my account"} ).and_return(@account)

      put :update, {:id => 10, :account => {:title => "my account"}}
      response.should redirect_to(:action => :show, :id => 10)
    end
  end
end
