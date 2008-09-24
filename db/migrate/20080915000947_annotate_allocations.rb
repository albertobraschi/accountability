class AnnotateAllocations < ActiveRecord::Migration
  def self.up
    add_column :outgoing_category_allocations, :comment, :string
  end

  def self.down
    remove_column :outgoing_category_allocations, :comment
  end
end
