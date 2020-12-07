FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { '123456' }
    role { 'admin' }
  end

  factory :story do
    title { Faker::Name.name }
    content { Faker::Name.name }
    association :user, factory: :user
  end
end
