class Score < ActiveRecord::Base
  has_many :matches
  has_many :teams, through: :matches

  validates :score_home, presence: true, numericality: { only_integer: true, greater_than: -1, less_than: 11 }
  validates :score_away, presence: true, numericality: { only_integer: true, greater_than: -1, less_than: 11 }
end
