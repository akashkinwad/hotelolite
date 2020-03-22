class Api::V1::ApiController < ActionController::API
  include ActionController::MimeResponds

  before_action :authenticate!

  private

  def authenticate!
    render json: { error: 'Not Authorized' }, status: 401 unless api_token
  end

  def api_token
    return unless request.headers['x-api-key']
    @api_token ||= ApiToken.find_by(token: request.headers['x-api-key'])
  end

end
