class InvitationsController < ApplicationController
  def show
    invitation = Invitation.find(params[:id])
    @guests = invitation.guests
    @questions = Question.all
  end
end
