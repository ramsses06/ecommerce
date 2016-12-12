FactoryGirl.define do
  factory :product do
    name "producto de prueba"
    pricing "7.77"
    description "descripcion de prueba"
    association :user, factory: :user
  end
end
