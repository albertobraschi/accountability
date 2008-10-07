class Incoming < ActiveRecord::Base
  belongs_to :account

  named_scope :up_until, lambda { |d| 
    d = d.to_date.to_s 
    {:conditions => ['incoming_date <= ?',d] }
  }

#  has_many :incoming_category_allocations do
#    def total
#      find(:all).sum(&:total)
#    end
#  end
#
#  has_many :incoming_categories, :through => :incoming_category_allocations
#
#  def self.sum_to_date sum_date=Date.today
#    self.up_until(sum_date).sum('amount').to_s.to_d
#  end
#
#  def amount_allocated
#    (self.incoming_category_allocations.sum(:amount) || 0.0).to_s.to_d
#  end
#
#  def fully_allocated?
#    (self.amount == self.amount_allocated )
#  end 

#  def amount_unallocated
#    self.amount - self.amount_allocated
#  end
end
