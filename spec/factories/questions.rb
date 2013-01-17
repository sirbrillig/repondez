# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :string_question, class: Question do
    label "How are you?"
    field_type "string"
  end

  factory :boolean_question, class: Question do
    label "Are you happy?"
    field_type "boolean"
  end

  factory :text_question, class: Question do
    label "Comments?"
    field_type "text"
  end
end
