require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutgoingCategoryAllocationsController do
 

  it "should raise error without parent context" do
    lambda{ get :new }.should raise_error(OutgoingCategoryAllocationsController::NoParentSupplied)
  end

  describe " working in context of outgoing " do
    before(:each) do
      @outgoing = mock("outgoing")
      Outgoing.stub!(:find).and_return(@outgoing)
      @allocation = mock("outgoing_category_allocation")
      @allocation.stub!(:id).and_return(1)
      @outgoing.stub!(:outgoing_category_allocations).and_return(@allocation)
      @allocation.stub!(:outgoing_id).and_return(999)
      @allocation.stub!(:outgoing).and_return(@outgoing)
    end


    it "should get new allocation  outgoing item" do
      @outgoing.outgoing_category_allocations.should_receive(:build)
      get :new, :outgoing_id => '999'
      response.should be_success
    end
  end
end
