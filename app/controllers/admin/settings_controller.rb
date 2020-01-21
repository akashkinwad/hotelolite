class Admin::SettingsController < Admin::AdminsController

  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  def index
    @settings = Setting.page(params[:page]).per(20)
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(setting_params)
    respond_to do |format|
      if @setting.save
        format.html { redirect_to admin_settings_path, notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end
  def edit; end

  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to admin_settings_path, notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to admin_settings_url, notice: 'Setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_setting
      @setting = Setting.find(params[:id])
    end

    def setting_params
      params.require(:setting).permit(:key, :value)
    end

    def set_breadcrumb_menu
      breadcrumb(:settings)
    end

end
