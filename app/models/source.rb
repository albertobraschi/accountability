class Source < ActiveRecord::Base
  has_many :outgoings
  validates_presence_of :source_type
end
