require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Outgoing do
  before(:each) do
    @valid_attributres = {
      :detail => "Flushed some money",
      :amount => 10.50,
      :outgoing_date => "2008/10/10"
    }
  end

  it "should create a new instance" do
    (@outgoing = Outgoing.create)
  end

end
