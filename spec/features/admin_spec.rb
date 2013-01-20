require 'spec_helper.rb'

describe "The guest list page" do
  context "without logging-in" do
    before { visit guests_url }
    it "displays a login page" do
      page.should have_field 'user[email]'
    end
  end

  context "when logged-in" do
    before do
      @user = FactoryGirl.create :user
      @guest1 = FactoryGirl.create :guest1
      @guest2 = FactoryGirl.create :guest2
      @invite1 = FactoryGirl.create :invitation
      @invite1.guests << @guest1

      visit guests_url
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_on 'Sign in'

      visit guests_url
    end

    it "displays a guest that's not assigned to an invitation" do
      page.should have_content @guest2.first_name
    end

    it "displays a guest that is assigned to an invitation" do
      page.should have_content @guest1.first_name
    end

    it "displays a link to create a new guest" do
      page.should have_link_to new_guest_url
    end

    it "displays a selection for each guest to assign an invitation" do
      page.should have_select "guest_#{@guest1.id}_invitation"
    end

    context "when an invitation is selected for a guest" do
      before do
        within(:css, ".guest_#{@guest2.id}") do
          select @invite1.guest_list, from: "guest_#{@guest2.id}_invitation"
          click_on 'Save'
          @invite1.reload
        end
      end

      it "displays the guest as having that invitation" do
        page.should have_select "guest_#{@guest1.id}_invitation", selected: @invite1.guest_list
      end
    end

  end
end

describe "The new guest page" do
  context "without logging-in" do
    before { visit new_guest_url }
    it "displays a login page" do
      page.should have_field 'user[email]'
    end
  end

  context "when logged-in" do
    before do
      @user = FactoryGirl.create :user
      @guest1 = FactoryGirl.create :guest1
      @guest2 = FactoryGirl.create :guest2
      @guest3 = FactoryGirl.build :guest3
      @invite1 = FactoryGirl.create :invitation
      @invite1.guests << @guest1
      @old_size = Invitation.count

      visit new_guest_url
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_on 'Sign in'

      visit new_guest_url
    end

    it "does show guests with an invitation in the dropdown of other guests" do
      page.should have_content @guest1.first_name
    end

    it "does not show guests with no invitation in the dropdown of other guests" do
      page.should_not have_content @guest3.first_name
    end

    context "when the form is filled" do
      before do
        fill_in 'guest[first_name]', with: @guest3.first_name
        fill_in 'guest[last_name]', with: @guest3.last_name
      end

      context "with another guest (invitation) selected" do
        before do
          select @guest1.full_name, from: 'guest[invitation_id]'
          click_on 'Save'
          @new_guest = Guest.find_by_first_name_and_last_name(@guest3.first_name, @guest3.last_name)
        end

        it "does not create a new invitation" do
          Invitation.count.should eq @old_size
        end

        it "adds the new guest to the invitation of the other guest" do
          @new_guest.invitation.id.should eq @invite1.id
        end

        it "shows the guest with the invitation in the list page" do
          page.should have_select "guest_#{@new_guest.id}_invitation", selected: @invite1.guest_list
        end
      end

      context "without another invitation selected" do
        before do
          click_on 'Save'
        end
        
        it "creates a new invitation" do
          Invitation.count.should eq (@old_size + 1)
        end
        
        it "adds the new guest to the invitation" do
          new_guest = Guest.find_by_first_name_and_last_name(@guest3.first_name, @guest3.last_name)
          new_guest.invitation.id.should eq Invitation.last.id
        end
      end
    end
  end
end
