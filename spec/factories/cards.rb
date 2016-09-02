FactoryGirl.define do
  factory :card do
    original_text 'house'
    translated_text 'дом'
    review_date Time.now
    interval 1
    repeat 1
    efactor 2.5
    quality 5
    attempt 1
    user
  end
end
