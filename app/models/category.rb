class Category < ActiveRecord::Base
  has_many :category_allocations
  has_many :catgories, :through => :_category_allocations 
  validates_presence_of :name

  acts_as_nested_set
 
  CONVERSION_RATES = { :annually => 52.00,
                       :quaterly => 13.00,
                       :monthly =>  52.0 / 12.0,
                       :weekly => 1.0 
                      } 

  def remaining_budget
    self.budgeted_amount - (self._category_allocations.sum(:amount) || 0.00).to_d
  end

  def total_budget
    self.budgeted_amount
  end

  def total_remaining_budget
  end

  def exceeded_budget?
    remaining_budget < 0.0 ? true : false
  end

  def annual_budget
    convert_to :annually 
  end

  def total_annual_budget
  end

  def quaterly_budget
    convert_to :quaterly
  end

  def total_quaterly_budget
  end

  def monthly_budget
    convert_to :monthly
  end

  def total_monthly_budget
  end

  def weekly_budget
    convert_to :weekly
  end

  def total_weekly_budget
  end

  def convert_to(period, amount=budgeted_amount)
    period.downcase.to_sym if period.is_a? String
    (CONVERSION_RATES[period] / CONVERSION_RATES[budgeted_period_type.downcase.to_sym] * amount).to_d
  end
end
