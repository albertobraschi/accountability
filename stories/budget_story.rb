require File.dirname(__FILE__) + '/helper'
steps_for(:budgets) do
  Given "a category '$category'" do |category|
    @category = OutgoingCategory.create!(:name => category)
  end

  Given "there are no transactions against the category" do
    @category.outgoing_category_allocations.delete_all
    true
  end

  Given "reference date is '$today'" do |today|
    @today = today
  end

  When "the budget of '$category' is set to $amount '$budget_period' starting on '$budget_start_date'" do |category, amount, budget_period, budget_start_date|
    @category = OutgoingCategory.find_by_name(category)
    @category.budgeted_amount = amount.to_d
    @category.budgeted_period_type = budget_period
    @category.budgeted_period_start_date = budget_start_date
  end
  
  Then "the $budget_expressed_as budget of '$category' is $amount" do |budget_expressed_as, category,  amount|
    #@category =   @category = OutgoingCategory.save(:name => category)
    @category.send("#{budget_expressed_as}_budget").round(2).should eql(amount.to_s.to_d)
  end 

  Then "exceeded budget? is $bool" do |bool|
    @category.exceeded_budget?.should be_false
  end

end

with_steps_for(:budgets) do
  run "stories/budget_story" 
end
