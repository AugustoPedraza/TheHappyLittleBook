require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CartItemsController do

  # This should return the minimal set of attributes required to create a valid
  # CartItem. As you add validations to CartItem, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "book_id" => "1" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CartItemsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all cart_items as @cart_items" do
      cart_item = CartItem.create! valid_attributes
      get :index, {}, valid_session
      assigns(:cart_items).should eq([cart_item])
    end
  end

  describe "GET show" do
    it "assigns the requested cart_item as @cart_item" do
      cart_item = CartItem.create! valid_attributes
      get :show, {:id => cart_item.to_param}, valid_session
      assigns(:cart_item).should eq(cart_item)
    end
  end

  describe "GET new" do
    it "assigns a new cart_item as @cart_item" do
      get :new, {}, valid_session
      assigns(:cart_item).should be_a_new(CartItem)
    end
  end

  describe "GET edit" do
    it "assigns the requested cart_item as @cart_item" do
      cart_item = CartItem.create! valid_attributes
      get :edit, {:id => cart_item.to_param}, valid_session
      assigns(:cart_item).should eq(cart_item)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CartItem" do
        expect {
          post :create, {:cart_item => valid_attributes}, valid_session
        }.to change(CartItem, :count).by(1)
      end

      it "assigns a newly created cart_item as @cart_item" do
        post :create, {:cart_item => valid_attributes}, valid_session
        assigns(:cart_item).should be_a(CartItem)
        assigns(:cart_item).should be_persisted
      end

      it "redirects to the created cart_item" do
        post :create, {:cart_item => valid_attributes}, valid_session
        response.should redirect_to(CartItem.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cart_item as @cart_item" do
        # Trigger the behavior that occurs when invalid params are submitted
        CartItem.any_instance.stub(:save).and_return(false)
        post :create, {:cart_item => { "book_id" => "invalid value" }}, valid_session
        assigns(:cart_item).should be_a_new(CartItem)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CartItem.any_instance.stub(:save).and_return(false)
        post :create, {:cart_item => { "book_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested cart_item" do
        cart_item = CartItem.create! valid_attributes
        # Assuming there are no other cart_items in the database, this
        # specifies that the CartItem created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CartItem.any_instance.should_receive(:update_attributes).with({ "book_id" => "1" })
        put :update, {:id => cart_item.to_param, :cart_item => { "book_id" => "1" }}, valid_session
      end

      it "assigns the requested cart_item as @cart_item" do
        cart_item = CartItem.create! valid_attributes
        put :update, {:id => cart_item.to_param, :cart_item => valid_attributes}, valid_session
        assigns(:cart_item).should eq(cart_item)
      end

      it "redirects to the cart_item" do
        cart_item = CartItem.create! valid_attributes
        put :update, {:id => cart_item.to_param, :cart_item => valid_attributes}, valid_session
        response.should redirect_to(cart_item)
      end
    end

    describe "with invalid params" do
      it "assigns the cart_item as @cart_item" do
        cart_item = CartItem.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CartItem.any_instance.stub(:save).and_return(false)
        put :update, {:id => cart_item.to_param, :cart_item => { "book_id" => "invalid value" }}, valid_session
        assigns(:cart_item).should eq(cart_item)
      end

      it "re-renders the 'edit' template" do
        cart_item = CartItem.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CartItem.any_instance.stub(:save).and_return(false)
        put :update, {:id => cart_item.to_param, :cart_item => { "book_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cart_item" do
      cart_item = CartItem.create! valid_attributes
      expect {
        delete :destroy, {:id => cart_item.to_param}, valid_session
      }.to change(CartItem, :count).by(-1)
    end

    it "redirects to the cart_items list" do
      cart_item = CartItem.create! valid_attributes
      delete :destroy, {:id => cart_item.to_param}, valid_session
      response.should redirect_to(cart_items_url)
    end
  end

end
