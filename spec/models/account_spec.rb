require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../scenarios')

include Scenarios
include Scenarios::Categories
describe Account do

  describe "account validity" do
    before(:each) do
      @valid_attributes = {
        :title => "AN ACCOUNT",
        :account_type => "SOMETHING",
        :opening_balance => 100.00
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

  describe 'account balances' do
    before(:each) do
      @account =  Account.create(:title => "Wallet", 
                                 :account_type => "CASH", 
                                 :opening_balance => 223.00
                                )
      grocery_categories_scenario
    end

    it 'should have a current balance' do
      @account.current_balance.should_not  be_nil
      @account.current_balance.should eql BigDecimal('223')
    end

    it 'should have a statement balance' do
      pending
    end

    it 'should reflect outgoings in its balance' do
      outgoing = typical_outgoing_scenario
      @account.outgoings << outgoing
      @account.current_balance.should == 111.50.to_d
    end

    it 'should reflect incoming in its balance' do
      pending
      #incoming = typical_incoming_scenario
      #@account.incoming << incoming
      #@account.current_balance.should == 335.00.to_d
    end

  end
end
