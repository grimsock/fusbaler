class MatchesController < ApplicationController
  def new
    @match = Match.new
    @teams = Team.all
  end

  def create
    @match = Match.new(match_params)
    @teams = Team.all

    if @match.save
      redirect_to @match
    else
      render :new
    end
  end

  def show
    @match = Match.find(params[:id])
  end

  def index
    @matches = Match.all
  end

  def edit
    @match = Match.find(params[:id])
    @teams = Team.all
  end

  def update
    @match = Match.find(params[:id])
    @teams = Team.all

    if @match.update(match_params)
      redirect_to @match
    else
      render :edit
    end
  end

  private

  def match_params
    params.require(:match).permit(:team_home_id, :team_away_id, score_attributes: [:score_home, :score_away])
  end
end
