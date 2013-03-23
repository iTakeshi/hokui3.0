class Year < ActiveRecord::Base
  has_many :semesters

  validates_presence_of :class_year
  validates_uniqueness_of :class_year
end
