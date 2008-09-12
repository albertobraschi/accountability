class OutgoingCategoryAllocation < ActiveRecord::Base
 belongs_to :outgoing_category
 belongs_to :outgoing

 named_scope :of_name,
   lambda{ |name| 
     {:conditions => ["outgoing_categories.name = ?", name],
     :include => "outgoing_category"}
   } do 
     def total
        find(:all).sum(&:total)
     end
   end
 
  named_scope :by_outgoing,
    lambda{ |outgoing|
      { :conditions => ["outgoing_id = ?", outgoing] }
    }

  named_scope :by_categories_descending_from,
    lambda{ |category|
      { :conditions => {:outgoing_category_id => category.self_and_descendants.collect{|c| c}} }
    }

  def sub_allocations
    OutgoingCategoryAllocation.by_outgoing(self.outgoing).by_categories_descending_from(self.outgoing_category)
  end


#  def self.total
#    self.all.inject(0){|x, allocation| x + allocation.total - allocation.amount}
#  end

  def total
   self.sub_allocations.sum(:amount)
  end
end
