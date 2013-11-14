class RankingController < ApplicationController
  def index
    @ranking_positions = Ranking.default.first.ranking_positions.order(rank: :desc)
  end
end
