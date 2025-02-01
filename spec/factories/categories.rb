FactoryBot.define do 
    factory :category do
      sequence(:name) { |n| "Category#{n}" }
      sequence(:branch) { |n| "Branch#{n}" }
    end
  end
  