# == Schema Information
#
# Table name: products
#
#  id                      :integer          not null, primary key
#  name                    :string
#  pricing                 :integer
#  description             :text
#  user_id                 :integer
#  productimg_file_name    :string
#  productimg_content_type :string
#  productimg_file_size    :integer
#  productimg_updated_at   :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

FactoryGirl.define do
  factory :product do
    name "producto de prueba"
    pricing "7.77"
    description "descripcion de prueba"
    association :user, factory: :user
  end
end
