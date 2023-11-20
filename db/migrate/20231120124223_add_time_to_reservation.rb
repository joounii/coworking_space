class AddTimeToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :morning, :boolean, default: false
    add_column :reservations, :afternoon, :boolean, default: false
  end
end
