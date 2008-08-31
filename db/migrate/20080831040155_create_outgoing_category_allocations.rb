class CreateOutgoingCategoryAllocations < ActiveRecord::Migration
  def self.up
    create_table :outgoing_category_allocations do |t|
      t.integer :outgoing_category_id
      t.integer :flush_id
      t.decimal :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :outgoing_category_allocations
  end
end
