require 'spec_helper.rb'

describe "The users list page" do
  let (:user1) { FactoryGirl.create :user }

  context "without logging-in" do
    before { visit users_url }
    it "displays a login page" do
      page.should have_field 'user[email]'
    end
  end

  context "when logged-in" do
    before do
      visit users_url 
      fill_in 'user[email]', with: user1.email
      fill_in 'user[password]', with: user1.password
      click_on 'Sign in'

      visit users_url
    end

    it "displays the logged-in user" do
      page.should have_content user1.email
    end
  end
end

describe "The new user page" do
  let (:user1) { FactoryGirl.create :user }
  let (:user2) { FactoryGirl.build(:user, email: 'uncreated@foobar.com') }

  context "without logging-in" do
    before { visit new_user_url }
    it "displays a login page" do
      page.should have_field 'user[email]'
    end
  end

  context "when logged-in" do
    before do
      visit new_user_url 
      fill_in 'user[email]', with: user1.email
      fill_in 'user[password]', with: user1.password
      click_on 'Sign in'

      visit new_user_url 
    end

    it "displays the user form" do
      page.should have_field 'user[email]'
    end

    context "when creating a new user" do
      before do
        fill_in 'user[email]', with: user2.email
        fill_in 'user[password]', with: user2.password
        click_on 'Create User'
      end

      it "creates the new user" do
        User.find_by_email(user2.email).should_not be_nil
      end

      it "shows the new user" do
        page.should have_content user2.email
      end
    end
  end
end


