class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :seat

  state_machine :state, initial: :requesting do

    event :reservation_approved do
      transition requesting: :accepted
    end

    event :reservation_denied do
      transition requesting: :denied
    end
  end

end
