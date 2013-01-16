require 'spec_helper'

describe GuestController do

  describe "GET 'find'" do
    it "returns http success" do
      get 'find'
      response.should be_success
    end
  end

  describe "GET 'view'" do
    it "returns http success" do
      get 'view'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "the Find page" do
    context "looking for a non-existent name" do
      it "finds nothing" do
      end
    end

    context "looking for a name" do
      it "shows the guest" do
      end

      it "shows other guests who are on the same invitation" do
      end

      it "does not show guests who are not on the invitation" do
      end
    end
  end

end
