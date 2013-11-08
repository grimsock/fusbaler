class AddTeamToRankingPositions < ActiveRecord::Migration
  def change
    add_reference :ranking_positions, :team, index: true
  end
end
