class Car < ApplicationRecord
  has_one_attached :image

  has_many :reservations
  has_many :users, through: :reservations
end
