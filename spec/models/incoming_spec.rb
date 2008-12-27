require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../scenarios')

include Scenarios::In::Incomings
describe Incoming do

  describe "Balances at certain dates" do
    it 'should correctly sum incomings prior to dates given' do
      test_date = ('2005-03-25').to_date
      previous_incoming_scenario nil, test_date , 10
      Incoming.up_until('2005-10-10').length.should == 10
      Incoming.sum_to_date('2005-10-10').should == 11115.10.to_d
      (9..0).each do |index|
        Incoming.sum_to_date(test_date - index).should == newresult
      end
    end    
  end

end
