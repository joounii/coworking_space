class AddStatusToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :state, :string, default: "requesting"
  end
end
