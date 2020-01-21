class Admin::TournamentsController < Admin::AdminsController

  before_action :set_tournament, only: [:show, :edit, :update, :destroy]

  def index
    @tournaments = Tournament.page(params[:page]).per(20)
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to admin_tournaments_path, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @plans = @tournament.plans
  end

  def edit; end

  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to admin_tournaments_path, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tournament.destroy
    @tournaments = Tournament.all
    respond_to do |format|
      format.html { redirect_to admin_tournaments_url, notice: 'Tournament was successfully destroyed.' }
      format.js { render layout: false, action: 'destroy' }
      format.json { head :no_content }
    end
  end

  private
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    def tournament_params
      params.require(:tournament).permit(
        :name,
        :provider_id,
        :provider_tournament_id,
        :status,
        plan_ids: []
      )
    end

    def set_breadcrumb_menu
      breadcrumb(:tournaments)
    end

end
