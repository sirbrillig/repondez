# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    guest_id 1
    question_id 1
    answer_text "MyText"
  end
end
