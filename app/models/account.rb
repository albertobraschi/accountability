class Account < ActiveRecord::Base
  has_many :outgoings
  validates_presence_of :account_type
end
