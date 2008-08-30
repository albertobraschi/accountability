require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Source do
  before(:each) do
    @valid_attributes = {
      :title => "AN ACCOUNT",
      :source_type => "SOMETHING"
    }
  end

  it "should create a new instance given valid attributes" do
    (@source = Source.create!(@valid_attributes)).class.should be(Source)
    @source.should be_valid
  end

  it "should not create a source without a source type" do
    Source.new(:title => "An Account").should have(1).errors_on(:source_type)
  end


end
