class CheckoutController < ApplicationController  
    def index
        @user = current_user
        @order = current_user.orders.find_by(status: 'pending')
        @order_items = @order.present? ? @order.order_items.includes(:product) : []
    end
end
  