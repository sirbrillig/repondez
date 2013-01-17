require 'set'

shared_examples "a guest list page" do |guest1, guest2, guest3|
  it "shows the guest" do
    page.should have_content guest1.first_name
  end

  it "shows other guests who are on the same invitation" do
    page.should have_content guest2.first_name
  end

  it "does not show guests who are not on the invitation" do
    page.should_not have_content guest3.first_name
  end
end
