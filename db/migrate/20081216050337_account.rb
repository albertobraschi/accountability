class Account < ActiveRecord::Migration
  def self.up
    create_table "accounts", :force => true do |t|
      t.string   "title"
      t.string   "description"
      t.string   "account_name"
      t.string   "bsb"
      t.string   "account_number"
      t.string   "institution"
      t.string   "account_type"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.decimal  "opening_balance", :default => 0.0
      t.date     "opening_date"
    end
  end

  def self.down
    drop_table "accounts"
  end
end
