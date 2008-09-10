require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Outgoing do
  before(:each) do
    @valid_attributres = {
      :detail => "Flushed some money",
      :amount => 111.50,
      :outgoing_date => "2008/10/10"
    }
  end

  it "should create a new instance" do
    Outgoing.create(@valid_attributes).should be_instance_of(Outgoing)
  end

  it "should allocate outgoings" do
    @outgoing = Outgoing.create(@valid_attributes)
    #TODO: Check api... is there a better way to add to a join table
    @outgoing.outgoing_category_allocations.create(:outgoing_category => @groceries, :amount => 1.50) 
    @outgoing.fully_allocated?.should be_false
    @outgoing.amount_allocated?.should == 1.50
    @outgoing.amount_unallocated?.should == 110.00
    @outgoing.outgoing_category_allocations.create(:outgoing_category => @freshfood, :amount => 10.00) 
    @outgoing.fully_allocated?.should be_false
    @outgoing.outgoing_category_allocations.create(:outgoing_category => @veges, :amount => 25.00) 
    @outgoing.fully_allocated?.should be_false
    @outgoing.outgoing_category_allocations.create(:outgoing_category => @meat, :amount => 35.00) 
    @outgoing.fully_allocated?.should be_false
    @outgoing.outgoing_category_allocations.create(:outgoing_category => @organic, :amount => 60.00) 
    @outgoing.fully_allocated?.should be_false
    @outgoing.amount_allocated?.should == 135.50
    @outgoing.amount_unallocated?.should == -20.00
    @outgoing.outgoing_category_allocations.find_by_name(@organic.name).update_attributes!(:amount => 40.00) 
    @outgoing.amount_allocated?.should == 111.50
    @outgoing.amount_unallocated?.should == 0 
    @outgoing.outgoing_category_allocations.sum(&:amount).should == 111.50
    @outgoing.fully_allocated?.should be_true

    @outgoing.outgoing_category_allocations.find_by_name("Fresh Food").amount.should == 10.00
    @outgoing.outgoing_category_allocations.find_by_name("Fresh Food").sub_categories.total.should == 100.00
    @outgoing.outgoing_category_allocations.find_by_name("Fresh Food").total.should == 110.00
    @outgoing.outgoing_category_allocations.find_by_name("Groceries").sub_categories.total.should == 110.00
    @outgoing.outgoing_category_allocations.find_by_name("Groceries").total.total.should == 111.50
  end

  protected
  def setup_categories
    @groceries = OutgoingCategory.create( :name => "Groceries" )
    @freshfood = OutgoingCategory.create( :name => "Fresh Food" )
    @freshfood.move_to_child_of groceries
    @veges = OutgoingCategory.create(:name => "Fruit and Veges")
    @veges.move_to_child_of @freshfood
    @meat = OutgoingCategory.create(:name => "Meat")
    @meat.move_to_child_of @freshfood
    @organic = OutgoingCategory.create(:name => "Organic")
    @organic.move_to_child_of @veges
  end
end
