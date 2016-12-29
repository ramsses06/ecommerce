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

class ShoppingCart < ActiveRecord::Base
  include AASM

  has_many :in_shopping_carts, dependent: :destroy
  has_many :products, through: :in_shopping_carts
  #tiene muchos my_payments
  has_many :my_payments

  aasm column: "status" do
    state :created, initial: true
    state :payed
    state :failed

    event :pay do
      after do
        #Mandar los archivos que el usuario compro
        self.generate_links
      end
      transitions from: :created, to: :payed
    end
  end

  #encontrar el my_payment con estatus pagado
  def my_payment_payed
    begin #si no llegara e encontrar alguno pagado
      my_payments.payed.first
    rescue Exception => e
      return nil
    end
  end

  #Metodo para generar los links
  def generate_links
    self.products.each do |product|
      Link.create(expiration_date: DateTime.now + 7.days, product_id: product.id, email: my_payment_payed.email)
    end
  end

  #calcular el total de los productos del carrito
  def total
    products.sum(:pricing)
  end

  #Conseguir los items o productos en esta tabla Shopping_cart para mandarlos a las Clase de Paypal en Stores, -> paypal_form es un metodo en productos
  def items
    self.products.map{|product| product.paypal_form}
  end

end
