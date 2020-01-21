class ApplicationController < ActionController::Base
  before_action :make_action_mailer_use_request_host_and_protocol

  def breadcrumb(tab)
    @breadcrumb = { tab => 'kt-menu__item--open' }
  end

  def sub_menu(sub_tab)
    @sub_menu = { sub_tab => 'kt-menu__item--active' }
  end

  # private

  def after_sign_out_path_for(resource)
    if resource == :user
      "/users/sign_in"
    elsif resource == :admin
      "/admins/sign_in"
    else
      root_path
    end
  end

  def render_not_authorized_error
    respond_to do |format|
      format.html {
        render file: "#{Rails.root}/public/422",
        layout: false,
        status: 422
      }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  def authorize_user!
    unless current_user.id == params[:user_id].to_i
      render_not_authorized_error
    end
  end

  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

end
