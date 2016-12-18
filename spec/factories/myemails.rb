# == Schema Information
#
# Table name: myemails
#
#  id         :integer          not null, primary key
#  email      :string
#  ip         :string
#  state      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :myemail do
    email "MyString"
    ip "MyString"
    state 1
  end
end
