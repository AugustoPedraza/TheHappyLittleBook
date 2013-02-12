class CartsController < InheritedResources::Base

  def edit
    @cart = current_cart
    respond_to do |format|
      format.html {}
    end
  end
end
