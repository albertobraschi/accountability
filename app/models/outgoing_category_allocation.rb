class OutgoingCategoryAllocation < ActiveRecord::Base
 belongs_to :outgoing_category
 belongs_to :outgoing

 named_scope :of_name,
   lambda{ |name| 
     {:conditions => ["outgoing_category.name = ?", name],
    :joins => "outgoing_category"}
   }
end
