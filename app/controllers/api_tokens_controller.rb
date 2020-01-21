class ApiTokensController < UsersController

  before_action :find_api_token, only: [:edit, :update, :destroy]
  before_action :all_api_tokens, only: [:index, :create, :destroy]

  def index
    @api_token = ApiToken.new
  end

  def edit
    @api_token = ApiToken.find(params[:id])
  end

  def new
    @api_token = ApiToken.new
  end

  def create
    @user = current_user
    @api_token = @user.api_tokens.create(api_token_params)
    @api_token.save
    respond_to do |format|
      format.js { render layout: false, action: 'create' }
    end
  end

  def update
    @api_token.update(api_token_params)
    redirect_to api_tokens_path
  end

  def destroy
    @api_token.destroy
    respond_to do |format|
      format.js { render layout: false, action: 'destroy' }
    end
  end

  private

    def api_token_params
      params.require(:api_token).permit(:name, :token, :user_id)
    end

    def find_api_token
      @api_token = ApiToken.find(params[:id])
    end

    def all_api_tokens
      @api_tokens = current_user.api_tokens
    end

    def set_breadcrumb_menu
      breadcrumb(:api_tokens)
    end

end
