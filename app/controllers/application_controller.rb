class ApplicationController < ActionController::API
  before_action :authenticate_token!

  private

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find(payload['sub'])
  rescue JWT::VerificationError
    render json: { error: 'Invalid auth token' }, status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split.last
  end
end
