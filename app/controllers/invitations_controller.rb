class InvitationsController < ApplicationController
  def show
    @invitation = Invitation.find(params[:id])
    if @invitation and @invitation.guests and @invitation.guests.size > 0
      @guests = @invitation.guests
      @questions = Question.all
    else
      not_found
    end
  end

  def update
    @invitation = Invitation.find(params[:id])
    params[:answer].each_key do |guest_id|
      guest = Guest.find(guest_id)
      # FIXME: add answer
    end
  end
end
