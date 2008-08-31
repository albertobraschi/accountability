class CreateFlushes < ActiveRecord::Migration
  def self.up
    create_table :flushes, :force => true do |t|
      t.column :flushed_date, :date
      t.column :amount, :decimal
      t.column :detail, :string
      t.column :source_id, :integer
    end
  end

  def self.down
    drop_table :flushes
  end
end
