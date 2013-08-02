FactoryGirl.define do
  factory :weight_import do
    weighed_at { rand(1..100).days.ago }
    weight { rand(100..400) }
    fat { rand(10..50) }
    user
  end
end
