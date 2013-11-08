FactoryGirl.define do

  factory :player do
    sequence(:name) { |n| "player#{n}" }
  end

  factory :team do
    sequence(:name) { |n| "team#{n}" }
  end

  factory :score do
    sequence(:score_home) { rand(10) }
    sequence(:score_away) { rand(10) }
  end

  factory :match do
    association :team_home, factory: :team
    association :team_away, factory: :team
    score
  end
end
