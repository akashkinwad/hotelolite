class Api::V1::TournamentsController < Api::V1::ApiController
  # before_action :check_subscriptions, only: :show

  def index
    render json: ArenasService.tournaments
  end

  def show
    render json: ArenasService.tournament(params[:id])
  end
end
