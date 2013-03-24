class Semester < ActiveRecord::Base
  belongs_to :year
  has_and_belongs_to_many :subjects

  validates_presence_of :year_id
  validates_presence_of :identifier
end
