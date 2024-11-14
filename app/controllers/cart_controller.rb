class CartController < ApplicationController
    def index
        @order = current_user.orders.find_by(status: 'pending')
        @order_items = @order.present? ? @order.order_items.includes(:product) : []
    end
end