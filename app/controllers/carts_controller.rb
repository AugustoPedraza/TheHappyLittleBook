class CartsController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:show]

  def show
  end

  def edit
    @cart = current_cart
    respond_to do |format|
      format.html {}
    end
  end

  def update
    cart = Cart.find(params[:id])

    params[:items].values.each do |hash|
      id       = hash[:id].to_i
      quantity = hash[:quantity].to_i

      item     = cart.cart_items.find(id)

      item.update_quantity(quantity)
    end

    cart.make_purchase
    #Si no hay problemas, guardar el carrito como una compra
    #y hacer un redirect to show cart como pdf, donde se muestra la compra ya realizada.

    #Tener en cuenta que si el usuario no esta logeado, debo mandarlo a logearse,
    # y recien ver su compra realizada (paso anterior).

    respond_to do |format|
      format.js do
        render json:
        {
          status: :redirect,
          to:     cart_url(cart)
        }
      end
    end

    # "Hacer un redirect to show, para que muestre una tabla no editable,
    # con un botón de guardar pdf, y un botón de"
  end
end
