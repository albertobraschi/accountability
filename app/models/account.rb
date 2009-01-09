class Account < ActiveRecord::Base
  has_many :outgoings
  has_many :incomings
  has_many :statements
  validates_presence_of :account_type

  def current_balance at_date=Date.today
    opening_balance - (outgoings.sum_to_date(at_date) || 0.0) + (incomings.sum_to_date(at_date) || 0.0)
  end

end
