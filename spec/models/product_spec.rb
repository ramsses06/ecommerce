# == Schema Information
#
# Table name: products
#
#  id                      :integer          not null, primary key
#  name                    :string
#  pricing                 :decimal(10, 2)
#  description             :text
#  user_id                 :integer
#  productimg_file_name    :string
#  productimg_content_type :string
#  productimg_file_size    :integer
#  productimg_updated_at   :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  it{ should validate_presence_of :name }
  it{ should validate_presence_of :user }
  it{ should validate_presence_of :pricing }

  it "should validate pricing > 0" do
  	product = FactoryGirl.build(:product, pricing: 1.23)
  	puts product.inspect
  end

end
