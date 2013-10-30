class TeamsController < ApplicationController
  def new
    @team = Team.new
    @players = Player.all
  end

  def create
    @team = Team.new(team_params)
    @players = Player.all

    if @team.save
      redirect_to @team
    else
      render :new
    end
  end

  def show
    @team = Team.find(params[:id])
    @players = @team.players
  end

  def index
    @teams = Team.all
  end

  def edit
    @team = Team.find(params[:id])
    @players = Player.all
  end

  def update
    @team = Team.find(params[:id])
    @players = Player.all

    if @team.update(team_params)
      redirect_to @team
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :player_ids => [])
  end
end
