require 'spec_helper'

describe "A Guest" do
  describe "Find page" do
    before do
      visit find_guests_url
    end

    context "looking for a non-existent name" do
      before do
        fill_in 'First Name', with: 'aaaaaa'
        fill_in 'Last Name', with: 'bbbbbb'
        click 'Find'
      end

      it "finds nothing" do
        page.should have_field 'First Name'
      end
    end

    context "looking for an existant name that's not on an invitation" do
      before do
        @guest1 = FactoryGirl.create :guest1 
        fill_in 'First Name', with: @guest1.first_name
        fill_in 'Last Name', with: @guest1.last_name
        click 'Find'
      end

      it "finds nothing" do
        page.should have_field 'First Name'
      end
    end

    context "looking for a name that's on an invitation" do
      before do
        @guest1 = FactoryGirl.create :guest1
        @guest2 = FactoryGirl.create :guest2
        @guest3 = FactoryGirl.create :guest3
        @invite1 = FactoryGirl.create :invitation
        @invite1.guests << @guest1 << @guest2
        @invite1.save
      end

      context "when the name is entered exactly" do
        before do
          fill_in 'First Name', with: @guest1.first_name
          fill_in 'Last Name', with: @guest1.last_name
          click 'Find'
        end

        it_behaves_like "a guest list page", @guest1, @guest2, @guest3
      end

      context "when the name is entered differently-cased" do
        before do
          fill_in 'First Name', with: @guest1.first_name.upcase
          fill_in 'Last Name', with: @guest1.last_name.downcase
          click 'Find'
        end

        it_behaves_like "a guest list page", @guest1, @guest2, @guest3
      end
    end
  end

end
