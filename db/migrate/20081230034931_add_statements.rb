class AddStatements < ActiveRecord::Migration
  def self.up
    create_table :statements do |t|
      t.integer :account_id, :page_number
      t.date :from_date, :to_date
      t.decimal :opening_balance, :closing_balance
    end
  end

  def self.down
    drop_table :statements
  end
end
