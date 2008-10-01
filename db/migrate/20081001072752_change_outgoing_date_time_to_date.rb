class ChangeOutgoingDateTimeToDate < ActiveRecord::Migration
  def self.up
    change_column :outgoings, :outgoing_date, :date
  end

  def self.down
    change_column :outgoings, :outgoing_date, :datetime
  end
end
