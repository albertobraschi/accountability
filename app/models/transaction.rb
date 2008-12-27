class Transaction < ActiveRecord::Base
  belongs_to :account

  validates_numericality_of :amount

  named_scope :up_until, lambda { |d| 
    d = d.to_date.to_s 
    {:conditions => ['transaction_date <= ?',d] }
  }

  has_many :category_allocations do
    def total
      find(:all).sum(&:total)
    end
  end

  has_many :categories, :through => :category_allocations

  def self.sum_to_date sum_date=Date.today
    self.up_until(sum_date).sum('amount').to_s.to_d
  end

  def amount_allocated
    (self.category_allocations.sum(:amount) || 0.0).to_s.to_d
  end

  def fully_allocated?
    (self.amount == self.amount_allocated )
  end 

  def amount_unallocated
    self.amount - self.amount_allocated
  end
end
