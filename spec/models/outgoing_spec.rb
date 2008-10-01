require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../scenarios')

include Scenarios
include Scenarios::Outgoings
include Scenarios::Categories
include Scenarios::Allocations

describe Outgoing do


  describe "allocating amounts to categories" do
    before(:each) do

      @outgoing = typical_outgoing_scenario
      grocery_categories_scenario
      grocery_allocation_scenario @outgoing
    end

    it "should not be fully allocated allocate" do
      @outgoing.fully_allocated?.should be_false
      @outgoing.amount_allocated.should == 1.50.to_d
      @outgoing.amount_unallocated.should == 110.00.to_d
    end

    it "should sum > 1 allocation correctly" do
      freshfood_allocation_scenario @outgoing
      @outgoing.fully_allocated?.should be_false
      @outgoing.amount_allocated.should == 11.50.to_d
      @outgoing.amount_unallocated.should == 100.00.to_d
    end

    it "should not be fooled by over allocation" do
      freshfood_allocation_scenario @outgoing
      meat_n_vege_over_allocation_scenario @outgoing
      @outgoing.amount_allocated.should == 131.50.to_d
      @outgoing.amount_unallocated.should == -20.00.to_d
    end

    it "should fix over allocation, and acknowledge being fully allocated correctly" do
      freshfood_allocation_scenario @outgoing
      meat_n_vege_over_allocation_scenario @outgoing
      @outgoing.outgoing_category_allocations.of_name(@organic.name)[0].update_attributes!(:amount => 40.00) 
      @outgoing.amount_allocated.should == 111.50.to_d
      @outgoing.amount_unallocated.should == 0.0.to_d 
      @outgoing.fully_allocated?.should be_true
    end

    it "should peer deeply into its allocations successfully" do
      #this should is placed here to ensure that the outgoing id is correctly used
      #passed down the chain
      #freshfood_allocation_scenario @outgoing
      #meat_n_vege_allocation_scenario @outgoing
      #@outgoing.outgoing_category_allocations.of_name("Groceries")[0].total.should == 111.50
      #@outgoing.outgoing_category_allocations.of_name("Fresh Food")[0].amount.should == 10.00
      #@outgoing.outgoing_category_allocations.of_name("Fresh Food")[0].total.should == 110.00
    end
  end

  describe "Testing prior to date named_scope" do
    it 'should correctly sum outgoings prior to dates given' do
      test_date = ('2005-03-25').to_date
      previous_outgoings_scenario nil, test_date , 10
      Outgoing.up_until('2005-10-10').length.should == 10
      Outgoing.sum_to_date('2005-10-10').should == 115.0
      (9..0).each do |index|
        newresult +=  11.50
        Outgoing.sum_to_date(test_date - index).sum(&:amount).should == 11.50
      end
    end    
  end
end



