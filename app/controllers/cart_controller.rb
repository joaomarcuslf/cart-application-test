class CartController < ApplicationController
  include ApplicationHelper
  include CartHelper

  before_action :get_valid_cart!, only: [:index, :update, :update_cart, :pre_purchase, :order]
  before_action :check_if_total_changed!, only: [:index]
  before_action :filter_params_products, only: [:update_cart]
  before_action :filter_params_user, only: [:order]
  after_action :clear_notification, only: [:index]

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

    cart['total'] = nil
    session[:cart] = cart

    redirect_to cart_path
  end

  def pre_purchase
  end

  def order
    empty_cart!()

    flash[:notice] = "Your order is done!"

    # TODO: must implement the order purchase
    # TODO: this method should be on the checkout controller

    @user = params[:username]
  end

  def empty
    empty_cart!()

    flash[:notice] = "Your cart is empty!"

    redirect_to root_path
  end

  private
    def filter_params_user
      params.permit(:username)
    end

    def filter_params_products
      params.require(:products).permit!
    end

    def get_valid_cart!
      @cart_total = session[:cart]['total'].to_f if session[:cart]['total']

      @cart = format_cart!()
    end

    def check_if_total_changed!
      new_total = 0

      @cart.each do |product|
        new_total += product['total']
      end

      # Alert on price change

      if @cart_total && @cart_total != new_total then
        flash[:notice] = "Your cart value has been updated!";
      end

      session[:cart]['total'] = new_total
        
      @cart_total = new_total
    end

    def clear_notification
      flash[:notice] = nil
    end
end
