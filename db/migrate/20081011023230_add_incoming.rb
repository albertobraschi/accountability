class AddIncoming < ActiveRecord::Migration
  def self.up
    # Read an opinion piece the other day suggesting never to use STI
    # so trying this, wet as it is to see how it feels
    create_table "incomings", :force => true do |t|
      t.date    "incoming_date"
      t.decimal "amount"
      t.string  "detail"
      t.integer "account_id"
    end
  end

  def self.down
    drop_table "incomings"
  end
end
