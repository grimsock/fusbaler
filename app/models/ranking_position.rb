class RankingPosition < ActiveRecord::Base
  belongs_to :ranking

  validates :ranking, presence: true
  validates :rank, presence: true
end
