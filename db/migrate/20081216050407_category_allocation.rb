class CategoryAllocation < ActiveRecord::Migration
  def self.up
    create_table "category_allocations", :force => true do |t|
      t.integer  "category_id"
      t.integer  "transaction_id"
      t.decimal  "amount"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "comment"
    end
  end

  def self.down
    drop_table "category_allocations"
  end
end
