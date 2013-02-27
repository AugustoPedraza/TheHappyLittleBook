class CartsController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:show, :index, :update]

  def index
    @sales = Cart.sales_by_user(current_user.id)
  end

  def show
    @sale = Cart.find(params[:id])

    respond_to do |format|
      format.html {}
      format.pdf { render :pdf => "my_pdf",  :layout => 'layouts/pdf'}
    end
  end

  def edit
    @cart = current_cart
    respond_to do |format|
      format.html {}
    end
  end

  def update
    cart           = Cart.find(params[:id])
    updated_items  = []

    params[:items].values.each do |hash|
      id         = hash[:id].to_i
      quantity   = hash[:quantity].to_i

      updated_items << id
      cart_item     =  cart.cart_items.find(id)

      cart_item.update_quantity(quantity)
    end

    cart.cart_items.each do |cart_item|
      cart_item.destroy unless updated_items.include?(cart_item.id)
    end

    cart.make_sale
    # puts "="*50
    # puts current_user
    # puts "="*50
    cart.user = current_user
    cart.save
    session[:cart_id] = nil

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
