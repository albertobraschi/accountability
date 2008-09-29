require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Account do
  before(:each) do
    @valid_attributes = {
      :title => "AN ACCOUNT",
      :account_type => "SOMETHING"
    }
  end

  it "should create a new instance given valid attributes" do
    (@account = Account.create!(@valid_attributes)).class.should be(Account)
    @account.should be_valid
  end

  it "should not create a account without a account type" do
    Account.new(:title => "An Account").should have(1).errors_on(:account_type)
  end


end
