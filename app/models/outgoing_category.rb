class OutgoingCategory < ActiveRecord::Base
  has_many :outgoing_category_allocations
  has_many :flushes, :through => :outgoing_category_allocations 
end
