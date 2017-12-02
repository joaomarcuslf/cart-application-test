module CartHelper
  def get_cart_ids(cart)
    products = cart.keys
    products.delete('size')

    return products
  end

  def empty_cart
    return {
      'size' => 0
    }
  end

  def empty_cart!
    session[:cart] = empty_cart()
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

  def format_cart
    cart = []
    old_cart = session[:cart]

    old_cart ||= empty_cart()

    empty_cart!()

    product_ids = get_cart_ids(old_cart)

    product_ids.each do |id|
      begin
        product = Product.find(id)
        product_quant = old_cart[id]['quant']

        session[:cart][id] = {
          'quant' => product_quant,
          'id' => id
        }

        session[:cart]['size'] += product_quant

        cart.push(format_product(product, product_quant))
      rescue => e
        puts e
      end
    end

    return cart
  end
end
