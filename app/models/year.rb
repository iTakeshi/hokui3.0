class Year < ActiveRecord::Base
  validates_presence_of :class_year
  validates_uniqueness_of :class_year
end
