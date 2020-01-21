class Admin::SubscriptionsController < Admin::AdminsController

  before_action :find_users_and_plans, only: [:new, :create, :edit, :update]
  before_action :find_subscription, only: [:edit, :update, :show, :destroy]

  def index
    @subscriptions = Subscription.page(params[:page]).per(20)
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.resource = current_admin
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to admin_subscriptions_path, notice: 'Plans Subscription has been successfully created for user.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      @subscription.resource = current_admin
      if @subscription.update(subscription_params)
        format.html { redirect_to admin_subscriptions_path, notice: 'Plans Subscription has been successfully Updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to admin_subscriptions_path, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def subscription_params
      params.require(:subscription).permit(
        :auto_renewal,
        :has_trial,
        :start_time,
        :s_type,
        :active,
        :plan_id,
        :user_id
      )
    end

    def find_users_and_plans
      @plans = Plan.active
      @users = User.all
    end

    def set_breadcrumb_menu
      breadcrumb(:subscriptions)
    end

    def find_subscription
      @subscription = Subscription.find(params[:id])
    end
end
