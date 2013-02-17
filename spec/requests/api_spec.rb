require 'spec_helper.rb'

describe "The guests index API" do
  let! (:guest) { FactoryGirl.create :guest1 }
  let (:user) { FactoryGirl.create :user }

  context "guest index" do
    context "without logging-in" do
      before { get guests_url(format: :js) }

      it "displays an error" do
        response.body.should include "You need to sign in"
      end
    end

    context "after logging-in" do
      before do 
        post tokens_url(format: :json, email: user.email, password: user.password)
        token = JSON.parse(response.body)['token']
        get guests_url(format: :js, auth_token: token)
      end

      it "displays the list of users" do
        response.body.should include guest.first_name
      end
    end
  end

  context "sending no email and password" do
    before { post tokens_url(format: :json) }

    it "displays an error" do
      response.body.should include "must contain email and password"
    end
  end

  context "sending a valid email and password" do
    before { post tokens_url(format: :json, email: user.email, password: user.password) }

    it "returns the auth token" do
      response.body.should include "token"
    end
  end
end

