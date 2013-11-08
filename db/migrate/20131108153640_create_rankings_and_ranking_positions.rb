class CreateRankingsAndRankingPositions < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :name
      t.boolean :default

      t.timestamps
    end

    create_table :ranking_positions do |t|
      t.integer :rank
      t.belongs_to :ranking

      t.timestamps
    end
  end
end
