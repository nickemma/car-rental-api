class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :reservation_date, :due_date

  belongs_to :car
end
