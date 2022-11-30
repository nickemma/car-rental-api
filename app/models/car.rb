class Car < ApplicationRecord
  has_many_attached :images

  has_many :reservations
  has_many :users, through: :reservations
end
