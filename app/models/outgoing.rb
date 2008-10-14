class Outgoing < ActiveRecord::Base
  belongs_to :account

  #validates_presence_of :account
  validates_numericality_of :amount

  named_scope :up_until, lambda { |d| 
    d = d.to_date.to_s 
    {:conditions => ['outgoing_date <= ?',d] }
  }

  has_many :outgoing_category_allocations do
    def total
      find(:all).sum(&:total)
    end
  end

  has_many :outgoing_categories, :through => :outgoing_category_allocations

  def self.sum_to_date sum_date=Date.today
    self.up_until(sum_date).sum('amount').to_s.to_d
  end

  def amount_allocated
    (self.outgoing_category_allocations.sum(:amount) || 0.0).to_s.to_d
  end

  def fully_allocated?
    (self.amount == self.amount_allocated )
  end 

  def amount_unallocated
    self.amount - self.amount_allocated
  end
end
