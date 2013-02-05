class InvitationsController < ApplicationController
  def show
    @invitation = Invitation.find(params[:id])

    if @invitation and @invitation.guests and @invitation.guests.size > 0

      # If we got here searching for a guest, list that guest first.
      @guests = @invitation.guests.dup
      if session[:guest_id] and found_guest = Guest.find(session[:guest_id])
        @guests.delete found_guest
        @guests.unshift found_guest
      end

      @questions = Question.all

      respond_to do |format|
        format.html
        format.js
        format.json
      end

    else
      not_found
    end
  end

  def update
    @invitation = Invitation.find(params[:id])
    params[:answer].each_key do |guest_id|
      guest = Guest.find(guest_id)
      params[:answer][guest_id].each_key do |question_id|
        question = Question.find(question_id)
        answer = Answer.find_or_create_by_guest_id_and_question_id(guest.id, question.id)
        answer.answer_text = params[:answer][guest_id][question_id]
        answer.save
        guest.answers << answer
        question.answers << answer
      end
    end
  end
end
