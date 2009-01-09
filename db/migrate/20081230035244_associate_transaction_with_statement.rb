class AssociateTransactionWithStatement < ActiveRecord::Migration
  def self.up
    add_column :transactions, :statement_id, :integer
  end

  def self.down
    remove_column :transactions, :statement_id
  end
end
