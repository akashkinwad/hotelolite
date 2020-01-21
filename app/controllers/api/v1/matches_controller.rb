class Api::V1::MatchesController < Api::V1::ApiController
  before_action :check_subscriptions, only: :show

  def index
    render json: ArenasService.matches(params)
  end

  def show
    render json: ArenasService.match(params[:id])
  end
end
