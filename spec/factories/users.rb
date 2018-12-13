FactoryBot.define do
  factory :user do
    name { 'テストユーザー１のネーム' }
    email { '111@gmail.com' }
    password { 'qazwsx' }
    password_confirmation { 'qazwsx' }
  end

  factory :second_user, class: User do
    name { 'テストユーザー２のネーム' }
    email { '222@gmail.com' }
    password { 'edc293' }
    password_confirmation { 'edc293' }
    initialize_with { User.find_or_create_by(email: email)}
  end
end
