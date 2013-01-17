require 'spec_helper'

describe "An Invitation" do
  describe "View page" do
    let(:guest1) { FactoryGirl.create :guest1 }
    let(:guest2) { FactoryGirl.create :guest2 }
    let(:invite1) { FactoryGirl.create :invitation }

    before do
      invite1.guests << guest1 << guest2
      invite1.save

      visit view_invitation_path(invite1)
    end

    context "for the first guest" do
      it "shows the default question" do
        within :css, ".guest_#{guest1.id}" do
          page.should have_text 'attend'
        end
      end
    end

    context "for the second guest" do
      it "shows the default question" do
        within :css, ".guest_#{guest2.id}" do
          page.should have_text 'attend'
        end
      end
    end
  end

end
