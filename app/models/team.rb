class Team < ActiveRecord::Base
  has_and_belongs_to_many :players
  has_many :matches
  has_many :scores, through: :matches

  validates :name, presence: true, uniqueness: true, length: { maximum: 32 }
  validate :team_players_limit

  private

  def team_players_limit
    limit = 2
    if self.players.length > limit
      errors.add(:base, "Team players limit exceeded, should be #{limit}")
    end
  end
end
