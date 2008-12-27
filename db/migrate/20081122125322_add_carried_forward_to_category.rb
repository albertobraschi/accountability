class AddCarriedForwardToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :bought_forward, :decimal, :default => 0.0
    add_column :categories, :date_bought_forward, :date
  end

  def self.down
    remove_column :categories, :bought_forward
    remove_column :categories, :date_bought_forward
  end
end
