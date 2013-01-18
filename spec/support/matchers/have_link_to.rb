RSpec::Matchers.define :have_link_to do |expected|
  match do |actual|
    actual.has_xpath?("//a[@href=\"#{expected}\"]")
  end
end