class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to players_path, notice: "Jogador criado!" and return
    end

    render 'new'
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])

    if @player.update_attributes(player_params)
      redirect_to players_path, notice: "Jogador atualizado!" and return
    end

    render 'edit'
  end

  def destroy
    @player  = Player.find(params[:id])
    @player.destroy

    redirect_to players_path, notice: "Jogador excluído!" and return
  end

private
  def player_params
    params.require(:player).permit(:name, :number, :position)
  end
end
