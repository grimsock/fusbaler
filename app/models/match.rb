class Match < ActiveRecord::Base
  belongs_to :team_home, class_name: "Team"
  belongs_to :team_away, class_name: "Team"
  belongs_to :score, autosave: true

  accepts_nested_attributes_for :score

  validates :team_home, presence: true
  validates :team_away, presence: true
  validates_associated :score
  validate :identical_teams?

  after_create :set_rank

  def autosave_associated_records_for_score
    if existing_score = Score.find_by_score_home_and_score_away(score.score_home, score.score_away)
      self.score = existing_score
    else
      self.score.save!
      self.save!
    end
  end

  def set_rank
    unless self.draw?
      if ranking_position = RankingPosition.find_by_team_id(self.winner.id)
        ranking_position.rank += 1
        ranking_position.save!
      else
        RankingPosition.create!(team: winner, rank: 1, ranking: Ranking.default.first)
      end
    end
  end

  def teams
    [self.team_home, self.team_away]
  end

  def draw?
    self.score.score_home == self.score.score_away
  end

  def winner
    if self.score.score_home > self.score.score_away
      self.team_home
    elsif self.score.score_home < self.score.score_away
      self.team_away
    end
  end

  private

  def identical_teams?
    if self.team_home == self.team_away
      errors.add(:base, "Cannot play against self, select different teams")
    end
  end
end
