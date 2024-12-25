FactoryBot.define do
  factory :user do
    email { "test@kiwil.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
