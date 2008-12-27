class OutgoingCategoryAllocation < ActiveRecord::Base
  belongs_to :outgoing_category
  belongs_to :outgoing

  named_scope :belonging_to_category,
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

  named_scope :occuring_between, 
    lambda{ |from_date, to_date|
      { :conditions => [ "outgoing_date between ? and ?", from_date, to_date],
        :include => "outgoing"
      }
    }

  
  def sub_allocations
    OutgoingCategoryAllocation.by_outgoing(self.outgoing).by_categories_descending_from(self.outgoing_category)
  end

  def total
    self.sub_allocations.sum(:amount)
  end
end
