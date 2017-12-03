class CatalogController < ApplicationController
  include ApplicationHelper
  before_action :filter_params, only: [:product]

  def home
    @products = Product.all
  end

  def product
    id = params[:id]
    add_to_cart!(id)

    flash[:notice] = "Product added to your cart!"

    redirect_to :home
  end

  private
    def add_to_cart!(product)
      # The cart must store the total amount of
      # products stored, the total amount of a singular product
      # and, if the cart is valid, the total of all products
      # this is created on cart_controller

      id = product.to_s

      old_cart = session[:cart]

      old_cart ||= get_empty_cart()
      old_cart[id] ||= get_empty_product(id)

      begin
        formatted_product = get_valid_product(old_cart, id)
        formatted_product['quant']+=1
        old_cart[id] = formatted_product
      rescue => e
        puts e
        return e
      end

      old_cart['size']+=1

      old_cart.delete('total')

      session[:cart] = old_cart
    end

    def filter_params
      params.permit(:id)
    end
end
