FactoryGirl.define do
  factory :user do
    email "correo@prueba.com"
    password "12345678"
    password_confirmation "12345678"
  end
end