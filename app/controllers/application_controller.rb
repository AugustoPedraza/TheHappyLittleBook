class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_cart

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def authenticate_admin_user!
   redirect_to admin_root_path unless current_user.has_role? :admin
  end

  private
    def current_cart
      #Fixme: use the method find_or_create
      Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
