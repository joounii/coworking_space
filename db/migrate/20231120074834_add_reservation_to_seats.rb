class AddReservationToSeats < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :seat, null: false, foreign_key: true
  end
end
