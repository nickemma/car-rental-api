class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :car_id, presence: true
  validates :user_id, presence: true
  validates :reservation_date, presence: true
  validates :due_date, presence: true
end
