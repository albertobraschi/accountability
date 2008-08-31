class CreateOutgoingCategories < ActiveRecord::Migration
  def self.up
    create_table :outgoing_categories do |t|
      t.string :name
      t.integer :parent_id, :lft, :rgt

      t.timestamps
    end
  end

  def self.down
    drop_table :outgoing_categories
  end
end
