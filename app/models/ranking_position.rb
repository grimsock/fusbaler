class RankingPosition < ActiveRecord::Base
  belongs_to :ranking
  belongs_to :team

  validates :ranking, presence: true
  validates :rank, presence: true
end
