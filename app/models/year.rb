class Year < ActiveRecord::Base
  has_many :semesters
  has_many :users
  has_many :freeml_entries

  validates_presence_of :class_year
  validates_uniqueness_of :class_year

  def to_param
    class_year
  end

  def freeml_url
    "http://www.freeml.com/#{self.freeml_account}/topics"
  end
end
