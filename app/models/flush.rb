class Flush < ActiveRecord::Base
  belongs_to :sourced_from, :class_name => "Source"
end
