class Plans::SubscriptionsController < UsersController
  before_action :find_plan

  def index
    @plans = Plan.active
  end

  def new
    @subscription = @plan.subscriptions.new(s_type: params[:s_type])
    respond_to do |format|
      format.html
      format.js { render layout: false, action: 'new' }
    end
  end

  def edit
    @subscription = @plan.subscriptions.find(params[:id])
  end

  def update
    @subscription = @plan.subscriptions.find(params[:id])
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to user_path, notice: 'Subscription was Successfuly Updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors}
      end
    end
  end

  def create
    case params['payment_method']
      when "paypal"
        if params[:subscription][:s_type] == 'yearly'
          return_url = yearly_success_plan_subscriptions_url(@plan, auto_renewal: params[:subscription][:auto_renewal])
        else
          return_url = monthly_success_plan_subscriptions_url(@plan, auto_renewal: params[:subscription][:auto_renewal])
        end
        @payment = PaypalPayout.new(
          plan: @plan,
          return_url: return_url,
          cancel_url: plans_path,
          amount: calculate_amount
        ).send_paypal_request
        if @payment.create
          redirect_url = @payment.links.find {|link| link.rel == 'approval_url'}
          redirect_to redirect_url.href
        else
          redirect_to root_url, notice: @payment.error
        end
      when "stripe"
        @subscription = @plan.subscriptions.new subscription_params.merge(
          stripe_email: stripe_params["stripeEmail"],
          stripe_token: stripe_params["stripeToken"],
          user_id: current_user.id
        )
        if @subscription.valid?
          @subscription.process_payment
          @subscription.save
          @subscription.notifiy_user_and_admin
          @subscription.save_order_details
          redirect_to plans_path, notice: "Payment Succesful"
        else
          redirect_to plans_path, notice: "Payment failed, Please try again!"
      end
    end
  end

  def yearly_success
    success
  end

  def monthly_success
    success
  end

  def show

  end

  private

    def subscription_params
      params.require(:subscription).permit(
        :auto_renewal,
        :has_trial,
        :start_time,
        :s_type,
        :active
      )
    end

    def stripe_params
      params.permit :stripeEmail, :stripeToken
    end

    def find_plan
      @plan = Plan.find(params[:plan_id])
    end

    def calculate_amount
      if params[:subscription][:s_type] == 'yearly'
        @plan.price_per_year
      else
        @plan.price_per_month
      end
    end

    def success
      payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
      payer_id = params["PayerID"]
      if payment.execute(payer_id: payer_id)
        @order = Order.create(
          response: params.slice(:paymentId, :token, :PayerID),
          user_id: current_user.id
        )
        subscription_type = action_name == 'yearly_success' ? 'yearly' : 'monthly'

        @subscription = @plan.subscriptions.create(s_type: subscription_type, user: current_user, auto_renewal: params['auto_renewal'])
        @subscription.notifiy_user_and_admin
        @order.update_columns(
          subscription_id: @subscription.id,
          info: {
            amount: payment.transactions[0].amount.total,
            payer_email: payment.transactions[0].payee.email,
            currency: payment.transactions[0].amount.currency,
            payment_method: 'PayPal'
          }
        )
        redirect_to plans_path, notice: "Payment Succesful"
      else
        redirect_to plans_path, notice: "Payment failed, Please try again!"
      end
    end
end
