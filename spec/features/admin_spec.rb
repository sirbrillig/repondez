require 'spec_helper.rb'

describe "For an administrator" do

  context "The guest list page" do
    before do
      @guest1 = FactoryGirl.create :guest1
      @guest2 = FactoryGirl.create :guest2
      @invite1 = FactoryGirl.create :invitation
      @invite1.guests << @guest1
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

    it "displays a link to create a new invitation" do
      page.should have_link_to new_invitation_url
    end

    it "displays a selection for each guest to assign an invitation" do
      page.should have_select "guest_#{@guest1.id}_invitation"
    end

    context "when an invitation is selected for a guest" do
      before do
        select @invite1.id, from: "guest_#{@guest2.id}_invitation"
        click_on 'Save'
      end

      it "displays the guest as having that invitation" do
        page.should have_select "guest_#{@guest1.id}_invitation", selected: @invite1.id
      end
    end

  end
end
