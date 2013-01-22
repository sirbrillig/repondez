require 'spec_helper'

describe Guest do
  describe ".find_by_first_name_and_last_name" do
    context "when the name is differently-cased" do

      let(:guest) { FactoryGirl.create :guest1 }

      subject { Guest.find_by_first_name_and_last_name(guest.first_name.downcase, guest.last_name.upcase) }

      it("finds the correct Guest") { subject.full_name.should eq guest.full_name }

    end

    context "when the name has an apostrophe" do

      let (:guest) { FactoryGirl.create :guest1, last_name: "O'Hara" }

      subject { Guest.find_by_first_name_and_last_name(guest.first_name, guest.last_name) }

      it("finds the correct Guest") { subject.full_name.should eq guest.full_name }

    end
  end
end
