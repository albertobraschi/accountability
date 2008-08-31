require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SourcesController do
  integrate_views 
  describe "with plural actions" do

    it "should get index" do
      get :index
      response.should be_success
    end

  end

  describe " with singular actions" do

    before(:each) do
      @source = mock("source")

      Source.stub!(:find).and_return(@source)

      @source.stub!(:id).and_return(10)
      @source.stub!(:save).and_return(true)
      @source.stub!(:destroy!).and_return(@source)
    end

    it "should get show" do
      get :show, :id => 10
      response.should be_success
    end

    it "should get new" do
      get :new
      response.should be_success
    end

    it "should destroy source" do
      delete :destroy, :id => 10
      response.should be_redirect
    end

    it "should create source" do
      Source.should_receive(:create).with( {"title" => "my account"} ).and_return(@source)

      post :create, :source => {:title => "my account"}
      response.should redirect_to(:action => :index)
    end

    it "should update source" do
      @source.should_receive(:update_attributes).with( {"title" => "my account"} ).and_return(@source)

      put :update, {:id => 10, :source => {:title => "my account"}}
      response.should redirect_to(:action => :show, :id => 10)
    end
  end
end
