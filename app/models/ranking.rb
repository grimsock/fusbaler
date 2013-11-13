class Ranking < ActiveRecord::Base
  has_many :ranking_positions

  validates :name, presence: true

  scope :default, -> { where(default: true) }
end
