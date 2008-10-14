class AddBudgetedAmountsToCategories < ActiveRecord::Migration
  def self.up
    add_column :outgoing_categories, :budgeted_amount, :decimal
    add_column :outgoing_categories, :budgeted_period_type, :string, :default => "Annually"
    add_column :outgoing_categories, :budgeted_period_start_date, :date 
  end

  def self.down
    remove_column :outgoing_categories, :budgeted_amount
    remove_column :outgoing_categories, :budgeted_period_type
    remove_column :outgoing_categories, :budgeted_period_start_date
  end
end
