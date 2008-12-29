class Category < ActiveRecord::Base
  has_many :category_allocations
  has_many :catgories, :through => :_category_allocations 
  validates_presence_of :name

  acts_as_nested_set

  validates_presence_of :budgeted_period_start_date
  validates_presence_of :budgeted_period_type
  validates_presence_of :type

  CONVERSION_RATES = { :annually => 52.00,
                       :quaterly => 13.00,
                       :monthly =>  52.0 / 12.0,
                       :weekly => 1.0 
                      } 

  before_validation :set_defaults
  
  named_scope :incoming, :conditions => "type = 'incoming'"
  named_scope :outgoing, :conditions => "type = 'outgoing'"

  def set_defaults
    self.budgeted_period_type = "weekly" unless budgeted_period_type
    self.budgeted_period_start_date = Date.today  unless  budgeted_period_start_date
  end

  def remaining_budget
    if !date_bought_forward || date_bought_forward < this_period[:start]
      update_bought_forward
    end
    #refactor this so that a 'remaining budget' can be calculated for any period
    #when changing this also see that update_bought_forward reflects same logic for prevous period
    (self.budgeted_amount || 0.0) - (self.category_allocations.occuring_between(this_period[:start],this_period[:end]).sum(:amount).to_f || 0.0) + bought_forward 
  end

  def total_budget
    (self.budgeted_amount || 0.00) + (self.descendants.sum(:budgeted_amount).to_f || 0.0)
  end

  def total_remaining_budget
    total_budget - self.self_and_descendants.inject(0.00){|i,c| i +  (c.category_allocations.sum(:amount).to_f || 0.00)}
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
 
  def this_period
    days = (Date.today - budgeted_period_start_date)
    started = Date.today - (days % (CONVERSION_RATES[budgeted_period_type.downcase.to_sym] * 7.0 ))
    ended = started + 7 
    {:start => started, :end => ended}
  end
  
  def last_period
    {:start => (this_period[:start] - 7), :end => (this_period[:end]- 7)}
  end
 
 
  def this_period_as_conditions
    ["between ? and ?", self.this_period[:start], self.this_period[:end] ]
  end

  def last_period_as_conditions
    ["between ? and ?", self.last_period[:start], self.last_period[:end] ]
  end

  protected 
  def update_bought_forward
    self.bought_forward = (self.budgeted_amount || 0.0) - (self.category_allocations.occuring_between(last_period[:start],last_period[:end]).sum(:amount).to_f || 0.0) + bought_forward 
    self.date_bought_forward = Date.today
    save!
  end
end
