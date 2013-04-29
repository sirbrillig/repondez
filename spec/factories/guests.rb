# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest1, class: Guest do
    first_name "Dude"
    alias_first_name "Rock,Slab"
    alias_last_name "Huge,Barbell"
    last_name "Manguy"
  end

  factory :guest2, class: Guest do
    first_name "Joe"
    last_name "Foobar"
  end

  factory :guest3, class: Guest do
    first_name "Lady"
    last_name "McLadypants"
  end
end
