class CategoryAllocation < ActiveRecord::Base
  belongs_to :category
  belongs_to :outgoing, :class_name => "Outgoing", :foreign_key => :transaction_id
  belongs_to :incoming, :class_name => "Incoming", :foreign_key => :transaction_id


  named_scope :of_name,
    lambda{ |name| 
       {:conditions => ["categories.name = ?", name],
        :include => "category"}
    } do 
      def total
        find(:all).sum(&:total)
      end
  end
 
  named_scope :by_transaction,
    lambda{ |transaction|
      { :conditions => ["transaction_id = ?", transaction] }
    }

  named_scope :by_categories_descending_from,
    lambda{ |category|
      { :conditions => {:category_id => category.self_and_descendants.collect{|c| c}} }
    }
  named_scope :occuring_between, 
    lambda{|from_date, to_date|
      { :conditions => ["created_at between ? and ?", from_date, to_date]}
    } 

  
   def sub_allocations
     CategoryAllocation.by_transaction(self.transaction).by_categories_descending_from(self.category)
   end

   def total
     self.sub_allocations.sum(:amount)
   end
end
