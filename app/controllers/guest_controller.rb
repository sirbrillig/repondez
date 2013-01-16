class GuestController < ApplicationController
  def find
  end

  def view
    guest = Guest.find_by_first_name_and_last_name(params[:first_name], params[:last_name])
    redirect_to view_invitation_url(guest.invitation)
  end

  def update
    guest = Guest.find_by_first_name_and_last_name(params[:first_name], params[:last_name])
    guest.update_attributes(params[:guest])
    if guest.invitation
      redirect_to view_invitation_url(guest.invitation)
    else
      redirect_to view_guest_url(guest.invitation)
    end
  end
end
