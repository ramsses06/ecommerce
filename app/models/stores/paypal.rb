class Stores::Paypal
  include PayPal::SDK::REST

  #Declaro que esta variable pueden ser Read y Write
  attr_accessor :payment_VAR, :items, :total, :return_url, :cancel_url

  #En el construntor recibo las variables obligatorias y las opcionales
  def initialize(items, total, return_url, cancel_url, options={})
    self.items = items
    self.total = total
    self.return_url = return_url
    self.cancel_url = cancel_url
    options.each {|clave,valor| instance_variable_set("@#{clave}",valor)}
  end

  def process_payment
    self.payment_VAR = Payment.new(payment_options) #metodo de las opciones
    #retorna esta variable
    self.payment_VAR
  end

  def process_card(card_data)
    #me traigo las opciones de pago
    options = payment_options
    #Sobreescribo el payment_method
    options[:payer][:payment_method] = "credit_card"
    #Agrego las opciones faltantes para pago con credit card
    options[:payer][:funding_instruments] = [{
      credit_card: {
        type: CreditCardValidator::Validator.card_type(card_data[:number]),
        number: card_data[:number],
        expire_month: card_data[:expire_month],
        expire_year: card_data[:expire_year],
        cvv2: card_data[:cvv2],
        first_name: card_data[:first_name],
        last_name: card_data[:last_name]
      }
    }]
    self.payment_VAR = Payment.new(options) #metodo de las opciones
    #retorna esta variable
    self.payment_VAR
  end


  def payment_options
    {
        intent: "sale",
        payer:{
          payment_method: "paypal"
        },
        transactions: [
          {
            item_list: {
              items: self.items
            },
            amount:{
              total: self.total,
              currency: @divisa
            },
            description: "Compra todo lo que querais aqui mismo ;)"
          }
        ],
        redirect_urls: {
          return_url: self.return_url,
          cancel_url: self.cancel_url
        }
      }
  end

  # metodo que se manda a llamar desde payments_controller
  def self.checkoutMethod(payer_id, payment_id, &block)
    payment = Payment.find(payment_id)
    if payment.execute(payer_id: payer_id)
      yield if block_given?
    end
  end

  # metodo para devolver email de cuenta paypal
  def self.get_email(payment_id)
    payment = Payment.find(payment_id)
    payment.payer.payer_info.email
  end

end
