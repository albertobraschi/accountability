class Statement < ActiveRecord::Base
  belongs_to :account 
  has_many :transactions
  validates_uniqueness_of :page_number, :scope => :account_id
end
