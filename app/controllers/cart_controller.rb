class CartController < ApplicationController
  include CartHelper
  before_action :get_valid_cart, only: [:index, :update, :update_cart, :pre_purchase, :order]
  before_action :filter_params_products, only: [:update_cart]
  before_action :filter_params_user, only: [:order]

  def index
  end

  def update
  end

  def update_cart
    products = params[:products].to_h

    ids = products.keys

    cart = session[:cart]

    cart['size'] = 0

    ids.each do |id|
      quant = products[id]["'quant'"].to_i

      if quant > 0 then
        cart[id]['quant'] = quant
      else
        cart.delete(id)
      end

      cart['size'] += quant
    end


    session[:cart] = cart

    redirect_to cart_path
  end

  def pre_purchase
  end

  def order
    empty_cart!()

    @user = params[:user]
  end

  def empty
    empty_cart!()

    redirect_to root_path
  end

  private
    def filter_params_user
      params.permit(:username)
    end

    def filter_params_products
      params.require(:products).permit!
    end

    def get_valid_cart
      @cart = format_cart()
    end
end
