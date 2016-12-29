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

class Product < ActiveRecord::Base

	validates_presence_of :name, :pricing, :user
	validates :pricing, numericality: { greater_than: 0 }

	belongs_to :user
	has_many :attachments, dependent: :destroy

  #Relaciones para MyPayments de un producto
  has_many :in_shopping_carts
  has_one :shopping_cart, through: :in_shopping_carts
  has_many :my_payments, through: :shopping_cart

	has_attached_file :productimg, styles: { medium: "300x300", thumb:"100x100" }, default_url: "missing.png"
	validates_attachment_content_type :productimg, content_type: /\Aimage\/.*\Z/

  # Este metodo es mandado a llamar desde shopping_cart para guardar en un arreglo los productos con el FORMATO necesario.
  def paypal_form
    {name: name, sku: :item, price: pricing, currency: "USD", quantity: 1}
  end

  def my_payments_sales
    my_payments.payed
  end

  def product_sales
    my_payments.payed.count * self.pricing
  end


end
