class CarSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :car_type, :description, :brand, :daily_rate, :image

  def image
    return unless object.image.attached?

    {
      url: rails_blob_url(object.image)
    }
  end
end
