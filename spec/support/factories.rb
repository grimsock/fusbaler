FactoryGirl.define do
  factory :match do
    association :team_home, factory: :team
    association :team_away, factory: :team
    score
  end

  factory :player do
    sequence(:name) { |n| "player#{n}" }
  end

  factory :ranking do
    sequence(:name) { |n| "ranking#{n}" }

    factory :default_ranking do
      default true
    end
  end

  factory :ranking_position do
    association :ranking
    association :team
    rank 1
  end

  factory :score do
    sequence(:score_home) { rand(10) }
    sequence(:score_away) { rand(10) }
  end

  factory :team do
    sequence(:name) { |n| "team#{n}" }
  end
end
