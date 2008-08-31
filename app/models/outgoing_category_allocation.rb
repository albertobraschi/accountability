class OutgoingCategoryAllocation < ActiveRecord::Base
 belongs_to :outgoing_allocation
 belongs_to :flush
end
