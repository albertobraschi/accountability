require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../scenarios')


describe Outgoing do
  include Scenarios::Categories
  include Scenarios::Allocations

  describe "allocating amounts to categories" do
    before(:each) do
      grocery_categories_scenario
      @outgoing = Outgoing.create( { :detail => "Flushed some money",
        :amount => 111.50,
        :outgoing_date => "2008/10/10"
      })
    end

    it "should not be fully allocated allocate" do
      grocery_allocation_scenario @outgoing
      @outgoing.fully_allocated?.should be_false
      @outgoing.amount_allocated.should == 1.50.to_d
      @outgoing.amount_unallocated.should == 110.00.to_d
    end

    it "should sum > 1 allocation correctly" do
      grocery_allocation_scenario @outgoing
      freshfood_allocation_scenario @outgoing
      @outgoing.fully_allocated?.should be_false
      @outgoing.amount_allocated.should == 11.50.to_d
      @outgoing.amount_unallocated.should == 100.00.to_d
    end

    it "should not be fooled by over allocation" do
      grocery_allocation_scenario @outgoing
      freshfood_allocation_scenario @outgoing
      meat_n_vege_over_allocation_scenario @outgoing
      @outgoing.amount_allocated.should == 131.50.to_d
      @outgoing.amount_unallocated.should == -20.00.to_d
    end

    it "should fix over allocation, and acknowledge being fully allocated correctly" do
      grocery_allocation_scenario @outgoing
      freshfood_allocation_scenario @outgoing
      meat_n_vege_over_allocation_scenario @outgoing
      @outgoing.outgoing_category_allocations.of_name(@organic.name)[0].update_attributes!(:amount => 40.00) 
      @outgoing.amount_allocated.should == 111.50.to_d
      @outgoing.amount_unallocated.should == 0.to_d 
      @outgoing.outgoing_category_allocations.sum(&:amount).should == 111.50
      @outgoing.fully_allocated?.should be_true
    end
  end
end


#      @outgoing.outgoing_category_allocations.find_by_name("Fresh Food").amount.should == 10.00
#      @outgoing.outgoing_category_allocations.find_by_name("Fresh Food").sub_categories.total.should == 100.00
#      @outgoing.outgoing_category_allocations.find_by_name("Fresh Food").total.should == 110.00
#      @outgoing.outgoing_category_allocations.find_by_name("Groceries").sub_categories.total.should == 110.00
#      @outgoing.outgoing_category_allocations.find_by_name("Groceries").total.total.should == 111.50
