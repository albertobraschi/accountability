require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutgoingCategory do
  before(:each) do
    OutgoingCategory.destroy_all 
  end
    
  it "should create a new instance given valid attributes" do
    category = OutgoingCategory.create!(:name => "test_category")
    category.ancestors.should be_blank
    category.children.should be_blank
    category.descendants.should be_blank
    category.child?.should be_false
  end

  it "should create three root sibling and have correct right and left values" do
    category_one = OutgoingCategory.create!(:name => "one")
    category_two = OutgoingCategory.create!(:name => "two")
    category_three = OutgoingCategory.create!(:name => "three")
     
    category_one.left.should eql(1)
    category_three.right.should eql(6)

    category_one.right_sibling.should eql(category_two)
    category_two.right_sibling.should eql(category_three)
    category_three.right_sibling.should be_nil

    category_one.left_sibling.should be_nil
    category_two.left_sibling.should eql(category_one)
    category_three.left_sibling.should eql(category_two)
  end

  #TODO Refactor this
  it "should create  children and pass it around " do
    category_one = OutgoingCategory.create!(:name => "one")
    category_two = OutgoingCategory.create!(:name => "two")
    category_three = OutgoingCategory.create!(:name => "three")
    category_three.move_to_child_of category_one
    category_three.child?.should be_true
    category_three.root.should eql(category_one)
    category_three.parent.should eql(category_one)
    category_four = OutgoingCategory.create!(:name => "four")
    category_four.move_to_child_of category_one
    category_one.children.should eql([category_three, category_four])
    category_three.left_sibling.should be_nil
    category_three.right_sibling.should eql(category_four)
    category_four.left_sibling.should eql(category_three)
    category_four.right_sibling.should be_nil 
    category_three.move_right
    category_three.reload
    category_four.reload
    category_three.right_sibling.should be_nil
    category_three.left_sibling.should eql(category_four)
    category_one.children.should eql([category_four, category_three])
    category_four.move_to_child_of category_two
    category_four.reload
    category_three.reload
    category_one.children.should == [category_three]
    category_two.children.should == [category_four]
    category_four.parent.should == category_two 
  end

  it "should correctly sum child categories" do 
    pending
  end

  it "should alert if sub categories are over budgeted" do
    pending
  end

  it "should set budget amount to total of children" do
    pending
  end

  it "should set budget amount to total of child budgets + own budget" do
  end

  it "should know own budget after amount of child budgets removed" do
  end
 
  describe "Category finding its place in time" do
    describe "--weekly--" do
      before(:each) do
        @category = OutgoingCategory.create( :name => "one", :budgeted_period_start_date => "2007-10-13".to_date, :budgeted_period_type => "weekly" )
      end

      it "should identify current periods start and end date for weekly budget" do
        class Date
          def self.today
            "2007-10-15".to_date
          end
        end
        @category.this_period[:start].should == "2007-10-13".to_date
        @category.this_period[:end].should == "2007-10-20".to_date
      end

      it "should identify current periods start  and end date for weekly budget" do
        class Date
          def self.today
            "2007-12-18".to_date
          end
        end
        puts Date.today
        @category.this_period[:start].should == "2007-12-15".to_date 
        @category.this_period[:end].should == "2007-12-22".to_date 
      end

    end
  end 
end
