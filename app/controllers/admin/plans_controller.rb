class Admin::PlansController < Admin::AdminsController

  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :initialize_redcarpet_renderer, :convert_markdown_features_to_html, only: [:create, :update]

  def index
    @plans = Plan.page(params[:page]).per(20)
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plans_params)
    @plan.tournaments = Tournament.all if @plan.allow_all_tournaments
    respond_to do |format|
      if @plan.save
        format.html { redirect_to admin_plans_path, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @tournaments = @plan.tournaments
  end

  def edit; end

  def update
    respond_to do |format|
      @plan.tournaments = Tournament.all if @plan.allow_all_tournaments
      if @plan.update(plans_params)
        format.html { redirect_to admin_plans_path, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to admin_plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_plan
      @plan = Plan.find(params[:id])
    end

    def plans_params
      params.require(:plan).permit(
        :name,
        :features,
        :price_per_month,
        :price_per_year,
        :calls_limit_per_hour,
        :active,
        :usage,
        :sports_type,
        :allow_all_tournaments,
        :free_trial_days,
        :is_available_monthly,
        :is_available_annually,
        tournament_ids: []
      )
    end

    def initialize_redcarpet_renderer
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    end

    def convert_markdown_features_to_html
      params[:plan][:features] = @markdown.render(plans_params["features"])
    end

    def set_breadcrumb_menu
      breadcrumb(:plans)
    end

end
