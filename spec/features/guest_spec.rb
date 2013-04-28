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
        @guest2 = FactoryGirl.create :guest2
        @guest3 = FactoryGirl.create :guest3
        @guest1 = FactoryGirl.create :guest1
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
          page.should have_content @guest1.full_name
        end

        it "shows other guests who are on the same invitation" do
          page.should have_content @guest2.first_name
        end

        it "does not show guests who are not on the invitation" do
          page.should_not have_content @guest3.first_name
        end
      end

      context "when searching for someone later on the list of names" do
        before do
          @invite1 = FactoryGirl.create :invitation
          @guest1 = FactoryGirl.create :guest1
          @guest4 = FactoryGirl.create :guest1, first_name: 'slart'
          @invite1.guests << @guest1 << @guest4
          visit find_guests_url
          fill_in 'guest[first_name]', with: @guest4.first_name
          fill_in 'guest[last_name]', with: @guest4.last_name
          click_button 'Find'
        end

        it "shows the first guest as the one who entered the name" do
          first(:css, ".guest").text.should eq @guest4.full_name
        end
      end

      context "when the name is entered differently-cased" do
        before do
          fill_in 'guest[first_name]', with: @guest1.first_name.upcase
          fill_in 'guest[last_name]', with: @guest1.last_name.downcase
          click_button 'Find'
        end

        it "shows the guest" do
          page.should have_content @guest1.full_name
        end

        it "shows other guests who are on the same invitation" do
          page.should have_content @guest2.first_name
        end

        it "does not show guests who are not on the invitation" do
          page.should_not have_content @guest3.first_name
        end
      end

      context "when the name entered is an alias to the last name" do
        before do
          fill_in 'guest[last_name]', with: @guest1.alias_last_name.split(',').last
          fill_in 'guest[first_name]', with: @guest1.first_name
          click_button 'Find'
        end

        it "shows the guest" do
          page.should have_content @guest1.full_name
        end

        it "shows other guests who are on the same invitation" do
          page.should have_content @guest2.first_name
        end

        it "does not show guests who are not on the invitation" do
          page.should_not have_content @guest3.first_name
        end
      end

      context "when the name entered is an alias to the first name" do
        before do
          fill_in 'guest[first_name]', with: @guest1.alias_first_name.split(',').first
          fill_in 'guest[last_name]', with: @guest1.last_name
          click_button 'Find'
        end

        it "shows the guest" do
          page.should have_content @guest1.full_name
        end

        it "shows other guests who are on the same invitation" do
          page.should have_content @guest2.first_name
        end

        it "does not show guests who are not on the invitation" do
          page.should_not have_content @guest3.first_name
        end
      end

      context "when the name has an apostrophe" do
        before do
          @guest5 = FactoryGirl.create :guest1, last_name: "O'Hara"
          @invite1.guests << @guest5
          fill_in 'guest[first_name]', with: @guest5.first_name
          fill_in 'guest[last_name]', with: @guest5.last_name
          click_button 'Find'
        end

        it "the guest exists" do
          Guest.find(@guest5.id).full_name.should eq @guest5.full_name
        end

        it "shows the guest" do
          page.should have_content @guest5.full_name
        end
      end
    end
  end

end
