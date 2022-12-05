class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  has_many :reservations, dependent: :destroy
  has_many :cars, through: :reservations

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :date_of_birth, presence: true

  def admin?
    admin
  end
end
