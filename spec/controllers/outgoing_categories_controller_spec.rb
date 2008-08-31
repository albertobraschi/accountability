require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutgoingCategoriesController do

  #Delete this example and add some real ones
  it "should use OutgoingCategoriesController" do
    controller.should be_an_instance_of(OutgoingCategoriesController)
  end

  it "should get /outgoing_categories" do
    get :index
    response.should be_success
  end

  it "should get new for categories, like /outgoing_categories/new" do
    get :new
    response.should be_success
  end
  
  describe " singular context actions " do
    before(:each) do
      @outgoing_category = mock("outgoing_category")
      OutgoingCategory.stub!(:find).and_return(@outgoing_category)
      @outgoing_category.stub!(:id).and_return(999)
    end

    it "should show category, like /outgoing_categories/999" do
      get :show, :id => 999
      response.should be_success
    end

    it "should get edit for categories, like /outgoing_categories/999/edit" do
      get :edit, :id => 999
      response.should be_success
    end

    it "should create category, like post /outgoing_categories" do
      OutgoingCategory.should_receive(:create!).with({"name" => "test"}).and_return(@outgoing_category)
      post :create, :outgoing_category => {:name => "test"}
      response.should be_redirect #_to outgoing_category_path(@outgoing_category.id)
    end

    it "should update category, like put /outgoing_categories/999" do
      @outgoing_category.should_receive(:update_attributes).with({"name" => "test"}).and_return(@outgoing_category)
      put :update, :id => '999', :outgoing_category => {:name => "test"}
      response.should redirect_to outgoing_categories_path
    end
  end
end