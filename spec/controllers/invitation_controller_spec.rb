require 'spec_helper'

describe InvitationController do

  describe "GET 'view'" do
    it "returns http success" do
      get 'view'
      response.should be_success
    end
  end

  describe "the View page" do
    context "for the first guest" do
      it "shows each question" do
      end
    end

    context "for the second guest" do
      it "shows each question" do
      end
    end
  end

end
