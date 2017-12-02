class CatalogController < ApplicationController
  before_action :filter_params, only: [:product]

  def home
    @products = Product.all
  end

  def product
    id = params[:id]
    add_to_cart(id)

    redirect_to :home
  end

  private
    def add_to_cart(product)
      id = product.to_s

      cart = session[:cart]

      cart ||= {
        'size' => 0
      }

      if !cart[id] then
        cart[id] = {
          'quant' => 0,
          'id' => id
        }
      end

      cart['size']+=1
      cart[id]['quant']+=1

      session[:cart] = cart
    end

    def filter_params
      params.permit(:id)
    end
end
