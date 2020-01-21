class PaymentDetailsController < UsersController

  before_action :find_user
  before_action :verify_user_payment_details, only: [:edit, :update, :destroy]
  before_action :find_payment_detail, only: [:edit, :update, :destroy]

  def index
    @payment_details = @user.payment_details.all
  end

  def new
    @payment_detail = @user.payment_details.new
  end

  def create
    @user = current_user
    @payment_detail = @user.payment_details.new(payment_detail_params)
    respond_to do |format|
      if @payment_detail.save
        format.html { redirect_to user_payment_details_path(@user), notice: 'Payment Details was successfully Created.'}
        format.json { render :index, status: :created, location: @payment_detail }
      else
        format.html { render :new }
        format.json { render json: @payment_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @payment_detail.update(payment_detail_params)
        format.html { redirect_to user_payment_details_path(@user), notice: 'Payment Details was Successfuly Updated.' }
        format.json { render :index, status: :ok, location: @payment_detail }
      else
        format.html { render :edit }
        format.json { render json: @payment_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment_detail.destroy
    respond_to do |format|
      format.html { redirect_to user_payment_details_path}
    end
  end

  private

    def payment_detail_params
      params.require(:payment_detail).permit(
        :cashholders_name,
        :card_number,
        :cvv,
        :address_line_1,
        :address_line_2,
        :city, :zipcode,
        :state,
        :country,
        expiry_date: [:month, :year]
      )
    end

    def find_user
      @user = User.find(params[:user_id])
    end

    def find_payment_detail
      @payment_detail = current_user.payment_details.find(params[:id])
    end

    def verify_user_payment_details
      ids = current_user.payment_details.ids
      unless ids.include?(params[:id].to_i)
        render_not_authorized_error
      end
    end

    def set_breadcrumb_menu
      breadcrumb(:payment_details)
    end

end
