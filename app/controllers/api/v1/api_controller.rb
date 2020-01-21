class Api::V1::ApiController < ActionController::API
  include ActionController::MimeResponds
  require 'json_web_token'

  before_action :authenticate!
  before_action :check_api_rate_limit

  private

  def authenticate!
    render json: { error: 'Not Authorized' }, status: 401 unless api_token
  end

  def api_token
    return unless request.headers['Api-Token']
    @api_token ||= ApiToken.find_by_token(request.headers['Api-Token'])
  end

  def api_user
    api_token.user if api_token.present?
  end

  def current_api_user?
    api_user.present?
  end

  def render_error(message:, status_code: 400)
    render json: { error: message }, status: status_code
  end

  def check_api_rate_limit
    if current_api_user? && api_rate_limiter.limit_exhausted?
      render_error(message: 'API Limit Exhausted', status_code: 429)
    end
  end

  def api_rate_limiter
    ApiRateLimiter.new(user: api_user, controller_path: controller_path, action_name: action_name)
  end

  def match_id
    params[:id].to_i
  end

  def check_subscriptions
    if !api_user.active_matches.pluck(:provider_id).include?(match_id)
      if api_user.matches.pluck(:provider_id).include?(match_id)
        error = 'Your Subscription is expired, Please renew your subsctiption to continue...'
      else
        error = 'You are not Subscribed to tournament. Please get subscription to continue...'
      end
      render_error(message: error, status_code: 403)
    end
  end

  protected
  # Validates the token and user and sets the @current_user scope
  def authenticate_request!
    if !payload || !JsonWebToken.valid_payload(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: {error: 'Invalid Request'}, status: :unauthorized
  end

  private
  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

  # Sets the @current_user with the user_id from payload
  def load_current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end

end
