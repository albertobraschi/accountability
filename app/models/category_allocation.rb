class CategoryAllocation < ActiveRecord::Base
  belongs_to :category
  belongs_to :transaction

  named_scope :of_name,
    lambda{ |name| 
       {:conditions => ["outgoing_categories.name = ?", name],
        :include => "category"}
    } do 
      def total
        find(:all).sum(&:total)
      end
  end
 
  named_scope :by_transaction,
    lambda{ |outgoing|
      { :conditions => ["transaction_id = ?", outgoing] }
    }

  named_scope :by_categories_descending_from,
    lambda{ |category|
      { :conditions => {:category_id => category.self_and_descendants.collect{|c| c}} }
    }

   def sub_allocations
     CategoryAllocation.by_transaction(self.transaction).by_categories_descending_from(self.category)
   end

   def total
     self.sub_allocations.sum(:amount)
   end
end
