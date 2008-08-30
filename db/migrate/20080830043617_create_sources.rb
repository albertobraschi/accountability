class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.string :title, :description, :account_name, :bsb, :account_number, :institution
      t.string  :source_type
      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end
end
