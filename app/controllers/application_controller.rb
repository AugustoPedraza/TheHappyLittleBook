class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_cart

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def authenticate_admin_user!
    redirect_to admin_root_path unless current_user.has_role? :admin
    # unless current_user
    #   puts "="*50
    #   puts "Sin usuario..."
    #   puts "="*50
    #   redirect_to new_user_session_path
    # else
    #   if current_user.has_role? :admin
    #     puts "="*50
    #     puts "Usuario admin"
    #     puts "="*50
    #     redirect_to admin_root_path
    #   else
    #     puts "="*50
    #     puts "Usuario comun..."
    #     puts "="*50
    #     redirect_to root_path
    #   end
    # end
  end

  def after_sign_in_path_for(resource_or_scope)
    root_path
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
