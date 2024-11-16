class OrdersController < ApplicationController
    def index
        @orders = current_user.orders.where(status: 'completed').includes(order_items: :product)
    end
end