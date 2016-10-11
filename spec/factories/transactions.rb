FactoryGirl.define do
  factory :transaction do
    association :material, factory: :material
    association :user, factory: :user
    operation 1
    ammount 100
  end
end
