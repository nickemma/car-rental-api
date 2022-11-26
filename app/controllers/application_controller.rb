class ApplicationController < ActionController::API
  before_action :authenticate_token!
  before_action :set_default_format

  private

  def set_default_format
    request.format = :json
  end

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find(payload['sub'])
  rescue JWT::VerificationError
    render json: { errors: ['Invalid auth token'] }, status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split.last
  end
end
