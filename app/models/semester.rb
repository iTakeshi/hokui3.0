class Semester < ActiveRecord::Base
  belongs_to :year
  has_and_belongs_to_many :subjects

  validates_presence_of :year_id
  validates_presence_of :identifier
  validates_uniqueness_of :identifier, scope: :year_id

  default_scope { order('identifier ASC') }

  def to_param
    identifier
  end

  def identifier_to_str
    "#{identifier[0]}年#{identifier[1] == 'a' ? '前期' : '後期'}"
  end
end
