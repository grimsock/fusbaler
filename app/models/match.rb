class Match < ActiveRecord::Base
  belongs_to :team_home, class_name: "Team"
  belongs_to :team_away, class_name: "Team"
  belongs_to :score, autosave: true

  accepts_nested_attributes_for :score

  validates :team_home, presence: true
  validates :team_away, presence: true
  validates_associated :score
  validate :identical_teams?

  def autosave_associated_records_for_score
    if existing_score = Score.find_by_score_home_and_score_away(score.score_home, score.score_away)
      self.score = existing_score
    else
      self.score.save!
      self.save!
    end
  end

  def teams
    [team_home, team_away]
  end

  private

  def identical_teams?
    if self.team_home == self.team_away
      errors.add(:base, "Cannot play against self, select different teams")
    end
  end
end
