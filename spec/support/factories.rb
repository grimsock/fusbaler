FactoryGirl.define do

  factory :player do
    sequence(:name) { |n| "player#{n}" }
  end
end
