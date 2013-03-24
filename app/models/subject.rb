class Subject < ActiveRecord::Base
  has_and_belongs_to_many :semesters

  validates_presence_of :title_en
  validates_uniqueness_of :title_en
  validates_presence_of :title_ja
  validates_uniqueness_of :title_ja
  validates_presence_of :staff_name
end
