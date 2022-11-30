class CarSerializer < ActiveModel::Serializer
  attributes :id, :name, :car_type, :description, :brand, :daily_rate, :images

  def images
    return unless object.images.attached?

    imgs_arr = []

    object.images.each do |img|
      imgs_arr << { url: rails_blob_url(img) }
    end
    imgs_arr
  end
end
