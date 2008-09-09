class OutgoingCategory < ActiveRecord::Base
  has_many :outgoing_category_allocations
  has_many :flushes, :through => :outgoing_category_allocations 
  validates_presence_of :name

  acts_as_nested_set

  

end
