class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?
  before_action :set_cart_badge

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def set_cart_badge
    if logged_in?
      @order = current_user.orders.find_by(status: 'pending')
      @cart_item_count = @order ? @order.order_items.sum(&:quantity) : 0
    else
      @cart_item_count = 0
    end
  end
end
