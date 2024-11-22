class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  helper_method :current_cart

  def current_cart
    session[:cart] ||= {}
  end

  allow_browser versions: :modern
end
