class RankingController < ApplicationController
  def index
    @ranking_positions = Ranking.default.first.ranking_positions.order(rank: :desc)
    p @ranking_positions
  end
end
