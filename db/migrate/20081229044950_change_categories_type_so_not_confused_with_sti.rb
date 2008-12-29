class ChangeCategoriesTypeSoNotConfusedWithSti < ActiveRecord::Migration
  def self.up
    rename_column :categories, :type, :applies_to
  end

  def self.down
    rename_column :categories,  :applies_to, :type
  end
end
