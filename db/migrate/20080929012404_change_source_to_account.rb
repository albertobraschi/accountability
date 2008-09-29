class ChangeSourceToAccount < ActiveRecord::Migration
  def self.up
    rename_table :sources, :accounts
    rename_column :outgoings, :source_id, :account_id
    rename_column :accounts, :source_type, :account_type

  end

  def self.down
    rename_table  :accounts, :sources
    rename_column :outgoings,  :account_id, :source_id
    rename_column :accounts,  :account_type, :source_type
  end
end
