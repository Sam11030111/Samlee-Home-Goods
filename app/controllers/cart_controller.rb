class CartController < ApplicationController
    def index
        @order = current_user.orders.find_by(status: 'pending')
        @order_items = @order.present? ? @order.order_items.includes(:product) : []
    end

    def update_quantity
        order_item = OrderItem.find(params[:id])

        if params[:button_action] == 'increase'
            order_item.quantity += 1
        elsif params[:button_action] == 'decrease'
            order_item.quantity -= 1
        elsif params[:button_action] == 'clear'
            order_item.quantity = 0
        end

        # If quantity becomes 0, delete the order_item
        if order_item.quantity == 0
            order_item.destroy
            puts "🗑️ Order item deleted!"
        else
            if order_item.save
                puts "✅ Order item updated successfully!"
            else
                puts "❌ Failed to update order item"
            end
        end

        # Recalculate total price after updating the item
        total_price = order_item.order.order_items.sum { |item| item.quantity * item.unit_price }

        # If the total price becomes 0, delete the order
        if total_price == 0
            order_item.order.destroy
            puts "🗑️ Order deleted as total price is 0!"
            redirect_to cart_path and return
        else
            order_item.order.update(total_price: total_price)
        end

         # Redirect based on source
        if params[:source] == 'checkout'
            redirect_to checkout_path
        else
            redirect_to cart_path
        end
    end
end