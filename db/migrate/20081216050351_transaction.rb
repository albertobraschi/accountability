class Transaction < ActiveRecord::Migration
  def self.up
    create_table "transactions", :force => true do |t|
      t.date    "transaction_date"
      t.decimal "amount"
      t.string  "detail"
      t.integer "account_id"
      t.string  "type"
    end
  end

  def self.down
    drop_table "transactions"
  end
end
