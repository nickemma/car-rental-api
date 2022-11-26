class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :date_of_birth, :admin, :token, :email, :avatar

  has_many :reservations

  def avatar
    return unless object.avatar.attached?

    {
      url: rails_blob_url(object.avatar)
    }
  end

  def token
    JsonWebToken.encode(sub: object.id)
  end
end
