FactoryGirl.define do
  factory :user do
    name { Faker::Namee.name }
    email 'john@doe.com'
    password 'johndoe'
  end
end
