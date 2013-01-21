class GuestsController < ApplicationController
  before_filter :authenticate_user!, except: [:find, :view]

  def index
    @questions = Question.all
    @guests = Guest.all
    @invitations = Invitation.all
  end

  def new
    @guest = Guest.new
    @guests = Guest.where('invitation_id IS NOT NULL')
  end

  def create
    @guest = Guest.new(params[:guest])
    @guest.invitation = Invitation.create if params[:guest][:invitation_id].empty?
    if @guest.save
      redirect_to guests_url, notice: 'Guest added!'
    else
      render action: 'new'
    end
  end

  def update
    @guest = Guest.find(params[:id])
    if @guest.update_attributes(params[:guest])
      redirect_to guests_url, notice: 'Guest updated!'
    else
      render action: 'index'
    end
  end

  def edit
    @guest = Guest.find(params[:id])
    @guests = Guest.where('invitation_id IS NOT NULL')
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    redirect_to guests_url
  end

  def find
    if request.post?
      guest = find_by_first_name_and_last_name(params[:guest][:first_name], params[:guest][:last_name])
      if guest and guest.invitation
        session[:guest_id] = guest.id
        redirect_to invitation_url(guest.invitation)
      else
        flash[:error] = "Sorry, I didn't find a guest by that name. #{view_context.mail_to('wedding@foolord.com', 'Send us an email', encode: 'javascript')} and we'll see what went wrong.".html_safe
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
