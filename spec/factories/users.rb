FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email 'john@doe.com'
    password 'johndoe'
  end
end
