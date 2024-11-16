class OrdersController < ApplicationController
    def index
        @orders = current_user.orders.includes(order_items: :product)
    end
end