class Match < ActiveRecord::Base
  belongs_to :team_home, class_name: "Team"
  belongs_to :team_away, class_name: "Team"
  belongs_to :score

  accepts_nested_attributes_for :score

  validates :team_home_id, presence: true, numericality: { only_integer: true }
  validates :team_away_id, presence: true, numericality: { only_integer: true }
  validates_associated :score
  validate :identical_teams?

  private

  def identical_teams?
    if self.team_home == self.team_away
      errors.add(:base, "Cannot play against self, select different teams")
    end
  end
end
