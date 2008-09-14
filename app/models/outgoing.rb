class Outgoing < ActiveRecord::Base
  belongs_to :source

  has_many :outgoing_category_allocations do
    def total
      find(:all).sum(&:total)
    end
  end

  has_many :outgoing_categories, :through => :outgoing_category_allocations


  def amount_allocated
    self.outgoing_category_allocations.sum(:amount) || 0
  end

  def fully_allocated?
    (self.amount == self.amount_allocated )
  end 

  def amount_unallocated
    self.amount - self.amount_allocated
  end
end
