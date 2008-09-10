class Outgoing < ActiveRecord::Base
  belongs_to :source
  has_many :outgoing_category_allocations
  has_many :outgoing_categories, :through => :outgoing_category_allocations

end
