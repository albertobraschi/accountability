class GiveAccountAnInitialBalance < ActiveRecord::Migration
  def self.up
    add_column :accounts, :opening_balance, :decimal, :default => 0
    add_column :accounts, :opening_date, :date
  end

  def self.down
    remove_column :accounts, :opening_balance
    remove_column :accounts, :opening_date
  end
end
