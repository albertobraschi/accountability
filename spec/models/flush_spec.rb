require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Flush do
  before(:each) do
    @valid_attributres = {
      :detail => "Flushed some money",
      :amount => 10.50,
      :flushed_date => "2008/10/10"
    }
  end

  it "should create a new instance" do
    (@flush = Flush.create)
  end
end
