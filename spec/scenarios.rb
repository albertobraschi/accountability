module Scenarios
  def typical_outgoing_scenario
    Outgoing.create( { :detail => "Flushed some money",
      :amount => 111.50,
      :outgoing_date => "2006/10/10"
    })
  end

  def typical_incoming_scenario
     Incoming.create( { :detail => "Got some money",
      :amount => 111.50,
      :incoming_date => "2006/10/10"
    })
  end

  module Out
    module Outgoings
      def previous_outgoings_scenario(account=nil, prior_to=DateTime.now, qty=10)
        qty.times do |index|
          Outgoing.create( { :detail => "A previous expense",
            :amount => 11.50,
            :outgoing_date => prior_to - index
          })
        end
       
      end
    end

    module Categories
      def grocery_categories_scenario
        @groceries = OutgoingCategory.create( :name => "Groceries", :budgeted_period_type => "WEEKLY", :budgeted_period_start_date => "2006/10/3" )
        @freshfood = OutgoingCategory.create( :name => "Fresh Food", :budgeted_period_type => "WEEKLY", :budgeted_period_start_date => "2006/10/3"  )
        @freshfood.move_to_child_of @groceries
        @veges = OutgoingCategory.create(:name => "Fruit and Veges", :budgeted_period_type => "WEEKLY", :budgeted_period_start_date => "2006/10/3" )
        @veges.move_to_child_of @freshfood
        @meat = OutgoingCategory.create(:name => "Meat", :budgeted_period_type => "WEEKLY", :budgeted_period_start_date => "2006/10/3" )
        @meat.move_to_child_of @freshfood
        @organic = OutgoingCategory.create(:name => "Organic", :budgeted_period_type => "WEEKLY", :budgeted_period_start_date => "2006/10/3" )
        @organic.move_to_child_of @veges
        [@groceries, @freshfood, @veges, @meat, @organic].each{|o| o.reload}
      end
    end
   
    module Allocations
      def grocery_allocation_scenario(allocated_to)
        allocated_to.outgoing_category_allocations.create(:outgoing_category => @groceries, :amount => 1.50) 
      end

      def freshfood_allocation_scenario(allocated_to)
        allocated_to.outgoing_category_allocations.create(:outgoing_category => @freshfood, :amount => 10.00) 
      end

      def meat_n_vege_over_allocation_scenario(allocated_to)
        allocated_to.outgoing_category_allocations.create(:outgoing_category => @veges, :amount => 25.00) 
        allocated_to.outgoing_category_allocations.create(:outgoing_category => @meat, :amount => 35.00) 
        allocated_to.outgoing_category_allocations.create(:outgoing_category => @organic, :amount => 60.00) 
      end

      def meat_n_vege_allocation_scenario(allocated_to)
        allocated_to.outgoing_category_allocations.create(:outgoing_category => @veges, :amount => 25.00) 
        allocated_to.outgoing_category_allocations.create(:outgoing_category => @meat, :amount => 35.00) 
        allocated_to.outgoing_category_allocations.create(:outgoing_category => @organic, :amount => 40.00) 
      end
    end
  end

  module In
    module Incomings
      def previous_incoming_scenario(account=nil, prior_to=DateTime.new, qty=10)
        qty.times do |index|
          Incoming.create({ :detail => 'a previous income',
              :amount => 1111.51,
              :incoming_date => prior_to - index
            }
          )
        end
      end
    end
  end
end
