require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutgoingCategoriesController do




  describe "root level categories" do
    before(:each) do
      @outgoing_category = mock("outgoing_category")
      OutgoingCategory.stub!(:find).and_return(@outgoing_category)
      @outgoing_category.stub!(:id).and_return(999)
      @outgoing_category.stub!(:errors).and_return(ActiveRecord::Errors.new(@outgoing_category))
      @outgoing_category.stub!(:parent).and_return(nil)
      @outgoing_category.stub!(:move_to_child_of).and_return(@outgoing_category)
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
      response.should be_redirect 
    end

    it "should update category, like put /outgoing_categories/999" do
      @outgoing_category.should_receive(:update_attributes).with({"name" => "test"}).and_return(@outgoing_category)
      put :update, :id => '999', :outgoing_category => {:name => "test"}
      response.should redirect_to(outgoing_categories_path)
    end

    it "should get /outgoing_categories" do
      OutgoingCategory.stub!(:find).and_return([@outgoing_category])
      get :index
      response.should be_success
    end

    it "should get new for categories, like /outgoing_categories/new" do
      get :new
      response.should be_success
    end

    it "should delete category" do
      @outgoing_category.should_receive(:destroy).and_return(@outgoing_category)
      @outgoing_category.should_receive(:name).and_return("test")
      delete :destroy, :id => '999'
      flash[:notice].should  == "Category test destroyed"
      response.should redirect_to(outgoing_categories_path)
    end
  end 

  describe " singular context actions " do
    before(:each) do
      @outgoing_category = mock("outgoing_category")
      @parent = mock("outgoing_category")
      OutgoingCategory.stub!(:find).and_return(@outgoing_category)
      @outgoing_category.stub!(:id).and_return(999)
      @outgoing_category.stub!(:errors).and_return(ActiveRecord::Errors.new(@outgoing_category))
      @outgoing_category.stub!(:parent).and_return(@parent)
      @outgoing_category.stub!(:move_to_child_of).and_return(@outgoing_category)
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
      response.should be_redirect 
    end

    it "should update category, like put /outgoing_categories/999" do
      @outgoing_category.should_receive(:update_attributes).with({"name" => "test"}).and_return(@outgoing_category)
      put :update, :id => '999', :outgoing_category => {:name => "test"}
      response.should redirect_to(outgoing_categories_path)
    end

    it "should get /outgoing_categories" do
      OutgoingCategory.stub!(:find).and_return([@outgoing_category])
      get :index
      response.should be_success
    end

    it "should get new for categories, like /outgoing_categories/new" do
      get :new
      response.should be_success
    end

    it "should delete category" do
      @outgoing_category.should_receive(:destroy).and_return(@outgoing_category)
      @outgoing_category.should_receive(:name).and_return("test")
      delete :destroy, :id => '999'
      flash[:notice].should  == "Category test destroyed"
      response.should redirect_to(outgoing_categories_path)
    end
  end
end
