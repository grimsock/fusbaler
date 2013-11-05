class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.belongs_to :team_home
      t.belongs_to :team_away
      t.belongs_to :score

      t.timestamps
    end
  end
end
