require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutgoingCategoryAllocation do
  before(:each) do
    @valid_attributes = {
      :outgoing_category_id => "1",
      :outgoing_id => "1",
      :amount => "9.99"
    }
  end

  it "should create a new instance given valid attributes" do
    OutgoingCategoryAllocation.create!(@valid_attributes)
  end

end
