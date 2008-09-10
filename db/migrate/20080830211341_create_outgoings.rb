class CreateOutgoings < ActiveRecord::Migration
  def self.up
    create_table :outgoings, :force => true do |t|
      t.column :outgoing_date, :date
      t.column :amount, :decimal
      t.column :detail, :string
      t.column :source_id, :integer
    end
  end

  def self.down
    drop_table :outgoings
  end
end
