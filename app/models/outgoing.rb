class Outgoing < ActiveRecord::Base
  belongs_to :source
  has_many :outgoing_category_allocations
  has_many :outgoing_categories, :through => :outgoing_category_allocations


  def amount_allocated
    self.outgoing_category_allocations.sum(:amount) 
  end

  def fully_allocated?
    puts self.amount
    puts self.amount_allocated
    (self.amount == self.amount_allocated )
  end

  def amount_unallocated
    self.amount - self.amount_allocated
  end
end
