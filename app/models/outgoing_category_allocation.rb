class OutgoingCategoryAllocation < ActiveRecord::Base
 belongs_to :outgoing_category
 belongs_to :flush
end
