# == Schema Information
#
# Table name: shopping_carts
#
#  id         :integer          not null, primary key
#  status     :string
#  ip         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  describe "status" do
  	it "can be set as payed" do
  		shopping_cart = FactoryGirl.create(:shopping_cart)
  		puts shopping_cart.status
  		shopping_cart.payed!
  		puts shopping_cart.status
  		expect(shopping_cart.status).to eq("payed")
  	end
  end
end
