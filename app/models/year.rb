class Year < ActiveRecord::Base
  has_many :terms

  validates_presence_of :class_year
  validates_uniqueness_of :class_year
end
