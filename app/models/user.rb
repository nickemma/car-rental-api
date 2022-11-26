class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  has_many :reservations
  has_many :cars, through: :reservations

  def admin?
    admin
  end

end
