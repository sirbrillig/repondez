# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    label "How are you?"
    field_type "string"
  end
end
