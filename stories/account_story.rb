require File.dirname(__FILE__) + '/helper'

steps_for (:accounts) do

  Given("a new $account_type account") do |account_type|
    @new_account = Account.new(:account_type => account_type)
  end
  
  Given("a number of existing accounts") do
    @initial_account_count = Account.count
  end

  When("I save the account") do
    @new_account.save
  end

  Then("the account should be valid") do
    @new_account.should be_valid
  end

  Then("there should be 1 more accounts") do
    Account.count.should == @initial_account_count + 1
  end 

  Given("an account called '$account' with an opening balance of $balance") do |account, balance|
    @account = Account.create!(
      :title => account, 
      :account_type => "CASH",
      :opening_balance => balance.to_d
    )
  end

   #TODO: Would prefer syntax like
    #outgoing.allocate_to :category => category, :amount => 10.00
    #OR 
    #@new_account.spend_amount_on :amount => 10.00, :category => category
    #OR
    #category.spent_from :account => "My Wallet", :amount => 10.00
    #
     

  When("$amount is spent on $category") do |amount, category|
    category = OutgoingCategory.find_or_create_by_name(category)
    outgoing = Outgoing.create(:amount => amount.to_d, 
                               :outgoing_date => Date.today 
                              )
    @account.outgoings << outgoing
    outgoing.save
    outgoing.outgoing_category_allocations.create(:amount => amount,
                                                  :outgoing_category => category
                                                 )
  end

  Then("the account should have a balance of $balance") do | balance |
    @account.current_balance.should == balance.to_d
  end

  Then("the category $category should  have a total of $total spend on it") do |balance|
    pending
  end

  Given("When $amount is deposited") do |account|
    @account.incomings <<  Incoming.create(:amount => amount.to_d, 
                               :outgoing_date => Date.today )
  end

end

with_steps_for(:accounts) do
  run "stories/account_story"
end


