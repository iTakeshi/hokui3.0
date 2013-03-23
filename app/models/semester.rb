class Semester < ActiveRecord::Base
  belongs_to :year

  validates_presence_of :year_id
  validates_presence_of :identifier
end
