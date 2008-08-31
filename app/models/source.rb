class Source < ActiveRecord::Base
  has_many :flushes
  validates_presence_of :source_type
  
end
