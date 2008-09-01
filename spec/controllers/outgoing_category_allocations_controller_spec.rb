require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutgoingCategoryAllocationsController do
 

  it "should raise error without parent context" do
    lambda{ get :new }.should raise_error(OutgoingCategoryAllocationsController::NoParentSupplied)
  end

  describe " working in context of flush " do
    before(:each) do
      @flush = mock("flush")
      Flush.stub!(:find).and_return(@flush)
      @allocation = mock("outgoing_category_animation")
      @allocation.stub!(:id).and_return(1)
      @flush.stub!(:outgoing_category_allocations).and_return(@allocation)
      @allocation.stub!(:flush_id).and_return(999)
      @allocation.stub!(:flush).and_return(@flush)
    end


    it "should get new allocation  flush item" do
      @flush.outgoing_category_allocations.should_receive(:build)
      get :new, :flush_id => '999'
      response.should be_success
    end
  end
end
