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

end

with_steps_for(:accounts) do
  run "stories/account_story"
end


