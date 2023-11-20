ActiveAdmin.register Reservation do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :reservation_date, :user, :seat, :state, :morning, :afternoon

  action_item :approve_reservation, only: :show do
    link_to 'Approve Reservation', approve_admin_reservation_path(reservation), method: :put if resource.requesting?
  end

  action_item :deny_reservation, only: :show do
    link_to 'Deny Reservation', deny_admin_reservation_path(reservation), method: :put if resource.requesting?
  end

  member_action :approve, method: :put do
    if resource.requesting?
      resource.reservation_approved!
      flash[:notice] = 'Reservation approved!'
    else
      flash[:alert] = 'Unable to approve reservation. Check the reservation status.'
    end
    redirect_to admin_reservation_path(resource)
  end

  member_action :deny, method: :put do
    if resource.requesting?
      resource.reservation_denied!
      flash[:notice] = 'Reservation denied!'
    else
      flash[:alert] = 'Unable to deny reservation. Check the reservation status.'
    end
    redirect_to admin_reservation_path(resource)
  end


  #
  # or
  #
  # permit_params do
  #   permitted = [:reservation_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
