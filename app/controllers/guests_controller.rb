class GuestsController < ApplicationController
  def find
    if request.post?
      guest = find_by_first_name_and_last_name(params[:guest][:first_name], params[:guest][:last_name])
      if guest and guest.invitation
        redirect_to invitation_url(guest.invitation)
      else
        flash[:error] = "No guest was found by that name."
      end
    end
  end

  def view
    guest = find_by_first_name_and_last_name(params[:guest][:first_name], params[:guest][:last_name])
    redirect_to invitation_url(guest.invitation)
  end

  private

  def find_by_first_name_and_last_name(first_name, last_name)
    Guest.where('lower(first_name) = ? AND lower(last_name) = ?', first_name.downcase, last_name.downcase).first
  end
end
