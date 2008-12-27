class Category < ActiveRecord::Migration
  def self.up
    create_table "categories", :force => true do |t|
      t.string   "name"
      t.integer  "parent_id"
      t.integer  "lft"
      t.integer  "rgt"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.decimal  "budgeted_amount"
      t.string   "budgeted_period_type",       :default => "Annually"
      t.date     "budgeted_period_start_date"
      t.string   "type"
    end
  end

  def self.down
    drop_table "categories"
  end
end
