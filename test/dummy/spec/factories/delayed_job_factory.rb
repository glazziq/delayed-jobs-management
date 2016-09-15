FactoryGirl.define do
  factory :delayed_job do
    handler 'test'
    run_at { Time.now + 2.days }
    queue 'default'

    trait :working do
      locked_at { Time.now }
    end

    trait :failed do
      last_error 'last errors'
    end

    trait :pending do
      attempts 0
      locked_at nil
    end

  end
end
