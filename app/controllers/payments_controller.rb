class PaymentsController < ApplicationController

  def checkout
    @my_payment = MyPayment.find_by(paypal_id: params[:paymentId])
    if @my_payment.nil?
      redirect_to "/carrito"
    else
      Stores::Paypal.checkoutMethod(params[:PayerID], params[:paymentId]) do
        #success
        @my_payment.update(email: Stores::Paypal.get_email(params[:paymentId])) #informacion del comprador (correo de cuenta paypal)
        @my_payment.pay!
        redirect_to ok_path, notice: "Se proceso el pago con PayPal"
        return
      end
      redirect_to carrito_path, notice: "Hubo un error al procesar pago"
    end
  end

  def create
    #hasta que el carrito tenga productos
    if @shopping_cart.products.empty?
      redirect_to carrito_path, notice: "Tu carrito esta vacio"
    else
      paypal_helper = Stores::Paypal.new(@shopping_cart.items, @shopping_cart.total, checkout_url, carrito_url, divisa: "USD")

      if paypal_helper.process_payment.create
        @my_payment = MyPayment.create!(paypal_id: paypal_helper.payment_VAR.id,
                                    ip: request.remote_ip,
                                    shopping_cart_id: cookies[:shopping_cart_id])
        redirect_to paypal_helper.payment_VAR.links.find{|v| v.method == "REDIRECT"}.href
      else
        raise paypal_helper.payment_VAR.error.to_yaml
      end
    end
  end

  def process_card
    if @shopping_cart.products.empty?
      redirect_to carrito_path, notice: "Tu carrito esta vacio"
    else
      paypal_helper = Stores::Paypal.new(@shopping_cart.items, @shopping_cart.total, checkout_url, carrito_url, divisa: "USD")

      if paypal_helper.process_card(params).create #mando los parametros de la tarjeta
        @my_payment = MyPayment.create!(paypal_id: paypal_helper.payment_VAR.id, ip: request.remote_ip, email: params[:email], shopping_cart_id: cookies[:shopping_cart_id])
        @my_payment.pay!
        redirect_to ok_path, notice: "Se proceso tu pago con tarjeta"
      else
        # redirect_to carrito_path, notice: paypal_helper.payment_VAR.error
        raise paypal_helper.payment_VAR.error.to_yaml
      end
    end
  end

end
