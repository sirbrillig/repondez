require 'spec_helper'

describe "A Guest" do
  describe "Find page" do
    before do
      visit find_guests_url
    end

    context "looking for a non-existent name" do
      before do
        fill_in 'guest[first_name]', with: 'aaaaaa'
        fill_in 'guest[last_name]', with: 'bbbbbb'
        click_button 'Find'
      end

      it "finds nothing" do
        page.should have_field 'guest[first_name]'
      end
    end

    context "looking for an existant name that's not on an invitation" do
      before do
        @guest1 = FactoryGirl.create :guest1 
        fill_in 'guest[first_name]', with: @guest1.first_name
        fill_in 'guest[last_name]', with: @guest1.last_name
        click_button 'Find'
      end

      it "finds nothing" do
        page.should have_field 'guest[first_name]'
      end
    end

    context "looking for a name that's on an invitation" do
      before do
        @guest1 = FactoryGirl.create :guest1
        @guest2 = FactoryGirl.create :guest2
        @guest3 = FactoryGirl.create :guest3
        @invite1 = FactoryGirl.create :invitation
        @invite1.guests << @guest1 << @guest2
      end

      context "when the name is entered exactly" do
        before do
          fill_in 'guest[first_name]', with: @guest1.first_name
          fill_in 'guest[last_name]', with: @guest1.last_name
          click_button 'Find'
        end

        it "shows the guest" do
          page.should have_content @guest1.first_name
        end

        it "shows other guests who are on the same invitation" do
          page.should have_content @guest2.first_name
        end

        it "does not show guests who are not on the invitation" do
          page.should_not have_content @guest3.first_name
        end

        it "shows the first guest as the one who entered the name"
      end

      context "when the name is entered differently-cased" do
        before do
          fill_in 'guest[first_name]', with: @guest1.first_name.upcase
          fill_in 'guest[last_name]', with: @guest1.last_name.downcase
          click_button 'Find'
        end

        it "shows the guest" do
          page.should have_content @guest1.first_name
        end

        it "shows other guests who are on the same invitation" do
          page.should have_content @guest2.first_name
        end

        it "does not show guests who are not on the invitation" do
          page.should_not have_content @guest3.first_name
        end
      end
    end
  end

end
