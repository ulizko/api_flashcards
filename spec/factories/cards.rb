FactoryGirl.define do
  factory :card do
    original_text { "house" + ('a'..'z').to_a.sample }
    translated_text { "дом" + ('а'..'я').to_a.sample }
    review_date Time.now
    interval 1
    repeat 1
    efactor 2.5
    quality 5
    attempt 1
    user
  end
end
