FactoryGirl.define do
  factory :item do
    name { FFaker::StarWars.character }
    done false
    todo_id nil
  end
end
