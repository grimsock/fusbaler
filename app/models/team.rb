class Team < ActiveRecord::Base
  has_and_belongs_to_many :players
  has_many :matches_home, class_name: "Match", foreign_key: 'team_home_id'
  has_many :matches_away, class_name: "Match", foreign_key: 'team_away_id'
  has_many :ranking_positions

  validates :name, presence: true, uniqueness: true, length: { maximum: 32 }
  validate :team_players_limit

  def matches
    Match.where('team_home_id = ? OR team_away_id = ?', id, id)
  end

  private

  def team_players_limit
    limit = 2
    if self.players.length > limit
      errors.add(:base, "Team players limit exceeded, should be #{limit}")
    end
  end
end
