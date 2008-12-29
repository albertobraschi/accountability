# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081229044950) do

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
    t.string   "applies_to"
    t.decimal  "bought_forward",             :default => 0.0
    t.date     "date_bought_forward"
  end

  create_table "category_allocations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "transaction_id"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment"
  end

  create_table "transactions", :force => true do |t|
    t.date    "transaction_date"
    t.decimal "amount"
    t.string  "detail"
    t.integer "account_id"
    t.string  "type"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
