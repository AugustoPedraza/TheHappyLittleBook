class CartsController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:show, :index]

  def index
    @purchases = Cart.purchases_by_user(current_user.id)
  end

  def show
    purchase = Cart.find(params[:id])

    respond_to do |format|
      format.html {}
      format.pdf { render :pdf => "my_pdf",  :layout => 'layouts/pdf'}
    end
    #Esto debería ser accedido via un link
  end

  def edit
    @cart = current_cart
    respond_to do |format|
      format.html {}
    end
  end

  def update
    cart             = Cart.find(params[:id])
    purchased_items  = []
    
    params[:items].values.each do |hash|
      id              = hash[:id].to_i
      quantity        = hash[:quantity].to_i

      purchased_items << id
      item            = cart.cart_items.find(id)

      item.update_quantity(quantity)
    end

    cart.cart_items.each{ |item| item.destroy unless purchased_items.include?(item.id)}

    cart.make_purchase
    puts "="*50
    puts current_user
    puts "="*50
    cart.user = current_user
    cart.save
    session[:cart_id] = nil

    #Recordar borrar los items que no estan presentes en los parametros

    respond_to do |format|
      format.js do
        render json:
        {
          status: :redirect,
          to:     cart_url(cart)
        }
      end
    end
  end
end
