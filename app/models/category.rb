class Category < ActiveRecord::Base
  has_many :category_allocations
  has_many :catgories, :through => :_category_allocations 
  validates_presence_of :name

  acts_as_nested_set

  validates_presence_of :budgeted_period_start_date
  validates_presence_of :budgeted_period_type
  validates_presence_of :type

  CONVERSION_RATES = { :annually => 52.00,
                       :half_yearly => 13.00,
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
    self.applies_to = 'incoming' unless applies_to
  end

  def remaining_budget(period=nil)
    if !date_bought_forward || date_bought_forward < this_period[:start]
      update_bought_forward
    end
    period = this_period unless period 
    periods_spanned = (period[:end] - period[:start]) / (CONVERSION_RATES[period_as_key] * 7.0 )
    periods_spanned -= 1.0 if periods_spanned >= 1.0
    bought_forward  + (periods_spanned * self.budgeted_amount) -  (self.category_allocations.occuring_between(period[:start],period[:end]).sum(:amount).to_f || 0.0)  
  end

  def total_budget
    (self.budgeted_amount || 0.00) + total_subcategory_budget
  end
 
  def total_subcategory_budget
    (self.descendants.inject(0.00){|i,c| i + (c.convert_to(self.period_as_key).to_f || 0.0)})
  end
  
  def total_remaining_budget
    total_budget - self.remaining_budget - total_remaining_subcategory_budget
  end

  def total_remaining_subcategory_budget
    #TODO - this needs to mindfully span corrent period, instead of just converting whats left in this period
    self.descendants.inject(0.00){|i,c| i +  (c.remaining_budget(this_period).to_f || 0.00)}
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
    period_as_key(period) if period.is_a? String
    (CONVERSION_RATES[period] / CONVERSION_RATES[period_as_key] * amount).to_d
  end
 
  def this_period
    days = (Date.today - budgeted_period_start_date)
    started = Date.today - (days % (CONVERSION_RATES[period_as_key] * 7.0 ))
    ended = started +  CONVERSION_RATES[period_as_key] * 7.0
    {:start => started, :end => ended}
  end
  
  def last_period
    {:start => (this_period[:start] - 7.0), :end => (this_period[:end]- 7.0)}
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
  
  def period_as_key(period = self.budgeted_period_type)
    period.gsub(" ","").tableize.singularize.to_sym
  end
end
