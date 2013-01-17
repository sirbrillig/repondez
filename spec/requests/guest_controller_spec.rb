require 'spec_helper'

describe "A Guest" do
  describe "Find page" do
    let(:guest1) { FactoryGirl.create :guest1 }
    let(:guest2) { FactoryGirl.create :guest2 }
    let(:guest3) { FactoryGirl.create :guest3 }

    before do
      visit 'guest/find'
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
        fill_in 'First Name', with: guest1.first_name
        fill_in 'Last Name', with: guest1.last_name
        click 'Find'
      end

      it "finds nothing" do
        page.should have_field 'First Name'
      end
    end

    context "looking for a name that's on an invitation" do
      let(:invite1) { FactoryGirl.create :invitation }

      before do
        invite1.guests << guest1 << guest2
        invite1.save
      end

      context "when the name is entered exactly" do
        before do
          fill_in 'First Name', with: guest1.first_name
          fill_in 'Last Name', with: guest1.last_name
          click 'Find'
        end

        it_behaves_like "a guest list page"
      end

      context "when the name is entered differently-cased" do
        before do
          fill_in 'First Name', with: guest1.first_name.upcase
          fill_in 'Last Name', with: guest1.last_name.downcase
          click 'Find'
        end

        it_behaves_like "a guest list page"
      end
    end
  end

end
