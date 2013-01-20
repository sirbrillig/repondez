# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    after(:create) { |user| user.confirm! }
    email 'foo@bar.com'
    password 'foobarfoobar'
  end
end
