module ApplicationHelper
  def get_empty_cart
    return {
      'size' => 0,
      'total' => 0
    }
  end

  def get_empty_product(id)
    return {
      'quant' => 0,
      'id' => id,
      'total' => 0,
      'name' => '',
      'price' => 0.0,
    }
  end

  def cart_size
    if session[:cart] && session[:cart]['size'] then
      session[:cart]['size']
    else
      0
    end
  end

  def format_product(product_instance, quant)
    product = {
      'id' => product_instance.id,
      'name' => product_instance.name,
      'price' => product_instance.price,
      'quant' => quant,
      'total' => product_instance.price  * quant
    }

    return product
  end
end

def get_valid_product(cart, id)
  product = Product.find(id)

  cart[id]['quant'] ||= 1
  product_quant = cart[id]['quant'].to_i

  formatted_product = format_product(product, product_quant)
end
