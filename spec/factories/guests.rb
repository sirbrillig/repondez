# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest1 do
    first_name "Dude"
    last_name "Manguy"
  end

  factory :guest2 do
    first_name "Joe"
    last_name "Foobar"
  end

  factory :guest3 do
    first_name "Lady"
    last_name "McLadypants"
  end
end
