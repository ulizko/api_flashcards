FactoryGirl.define do
  factory :card do
    sequence(:original_text, ['a'..'z']) { |n| "house#{n}" }
    sequence(:translated_text, ['a'..'z']) { |n| "дом#{n}" }
    review_date Time.now
    interval 1
    repeat 1
    efactor 2.5
    quality 5
    attempt 1
    user
  end
end
