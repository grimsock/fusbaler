class CreatePlayersTeams < ActiveRecord::Migration
  def change
    create_table :players_teams, id: false do |t|
      t.belongs_to :player
      t.belongs_to :team
    end
  end
end
