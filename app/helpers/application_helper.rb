module ApplicationHelper
  def cart_size
    if session[:cart] && session[:cart]['size'] then
      session[:cart]['size']
    else
      0
    end
  end
end
