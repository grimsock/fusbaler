FactoryGirl.define do

  factory :player do
    sequence(:name) { |n| "player#{n}" }
  end

  factory :team do
    sequence(:name) { |n| "team#{n}" }
  end
end
