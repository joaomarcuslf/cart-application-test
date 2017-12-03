module CartHelper
  def get_cart_ids(cart)
    products = cart.keys
    products.delete('size')
    products.delete('total')

    return products
  end

  def empty_cart!
    session[:cart] = get_empty_cart()
  end

  def format_cart!
    # TODO: there are too much logic on this method

    cart = []
    old_cart = session[:cart]

    old_cart ||= get_empty_cart()

    empty_cart!()

    product_ids = get_cart_ids(old_cart)

    old_cart['size'] = 0

    # This interation should search for the product on the DB
    # if it is valid:
    #     store the product on the session cart
    #     format it to be added on the preview cart
    # if it isn't:
    #      do not add to the cart, so it keep valid

    product_ids.each do |id|
      begin
        formatted_product = get_valid_product(old_cart, id)

        old_cart[id] = formatted_product
        old_cart['size'] += formatted_product['quant'].to_i

        cart.push(formatted_product)
      rescue => e
        # Product does not exist
      end
    end

    session[:cart] = old_cart

    return cart
  end
end
