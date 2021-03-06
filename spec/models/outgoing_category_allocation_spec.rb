require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../scenarios')

describe OutgoingCategoryAllocation do
  include Scenarios
  include Scenarios::Out::Categories
  include Scenarios::Out::Allocations

 before(:each) do
    #OutgoingCategoryAllocation.destroy_all
    #OutgoingCategory.destroy_all
    #Outgoing.destroy_all
    @outgoing = typical_outgoing_scenario
    grocery_categories_scenario
    grocery_allocation_scenario @outgoing
    freshfood_allocation_scenario @outgoing
    meat_n_vege_allocation_scenario @outgoing
 end

  it "should correctly find by name" do
    meat = OutgoingCategoryAllocation.belonging_to_category("Meat")
    meat.length.should == 1
    meat.should be_instance_of(Array)
    meat[0].should be_instance_of(OutgoingCategoryAllocation)
    meat[0].outgoing_category.should == (@meat)
  end

  it "should correctly find its children" do
    @outgoing.outgoing_category_allocations.belonging_to_category("Groceries")[0].sub_allocations.length.should eql(5)
    @outgoing.outgoing_category_allocations.belonging_to_category("Fresh Food")[0].sub_allocations.length.should eql(4)
    @outgoing.outgoing_category_allocations.belonging_to_category("Meat")[0].sub_allocations.length.should eql(1)
  end

  it "should correctly know its total" do
    @outgoing.outgoing_category_allocations.belonging_to_category("Groceries")[0].total.should eql(111.50)
    @outgoing.outgoing_category_allocations.belonging_to_category("Fresh Food")[0].amount.should == 10.00.to_d
    @outgoing.outgoing_category_allocations.belonging_to_category("Fresh Food")[0].total.should == 110.00.to_d
  end
  
  it "should apply total to collection" do
    @outgoing.outgoing_category_allocations.belonging_to_category("Fresh Food").total.should == 110.00.to_d 
  end
end
