class InvitationController < ApplicationController
  def view
    invitation = Invitation.find(params[:id])
    @guests = invitation.guests
  end
end
