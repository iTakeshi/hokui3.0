class MlAccount < ActiveRecord::Base
  has_many :ml_archives
  belongs_to :year
end
