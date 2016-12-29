class InShoppingCartsController < ApplicationController

  def create
    #agregar a carrito de compra
    in_shopping_cart = InShoppingCart.new(product_id: params[:product_id], shopping_cart_id: @shopping_cart.id)

    if in_shopping_cart.save
      redirect_to carrito_path, notice: "Producto agregado al carrito"
    else
      redirect_to products_path(id: params[:product_id]), notice: "No pudimos agregarlo al carrito"
    end
  end

  def destroy
    @in_shopping_cart = InShoppingCart.find(params[:id])
    @in_shopping_cart.destroy
    redirect_to carrito_path
  end

end
