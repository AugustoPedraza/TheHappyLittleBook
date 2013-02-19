class HomeController < ApplicationController
  before_filter :check_user

  def index
    @users = User.all
  end


  def check_user
    if current_user && current_user.has_role?(:admin)
      redirect_to admin_root_path
    end
  end
end
