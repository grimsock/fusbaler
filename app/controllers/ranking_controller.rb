class RankingController < ApplicationController
  skip_before_filter :authorize_user

  def index
    @ranking_positions = Ranking.default.first.ranking_positions.order(rank: :desc)
  end
end
