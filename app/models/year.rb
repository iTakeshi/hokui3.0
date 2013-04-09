class Year < ActiveRecord::Base
  has_many :semesters
  has_many :users
  has_one :ml_account

  validates_presence_of :class_year
  validates_uniqueness_of :class_year

  def to_param
    class_year
  end

  def current_semester
    t = Time.now
    year = t.year
    year -= 1 if t.month <= 2
    grade = year - self.class_year - 1917
    if (3..8).include? t.month
      self.semesters.find_by(identifier: "#{grade}a")
    else
      self.semesters.find_by(identifier: "#{grade}b")
    end
  end
end
