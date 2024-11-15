class CheckoutController < ApplicationController  
    def index
        @user = current_user
        @order = current_user.orders.find_by(status: 'pending')
        @order_items = @order.present? ? @order.order_items.includes(:product) : []
    end

    def checkout
        @order = current_user.orders.find_by(status: 'pending')
        
        if @order.present?
          ActiveRecord::Base.transaction do
            # Deduct stock for each product in the order
            @order.order_items.each do |item|
              product = item.product
              if product.stock >= item.quantity
                product.update!(stock: product.stock - item.quantity)
              else
                raise ActiveRecord::RecordInvalid, "Not enough stock for #{product.name}"
              end
            end
    
            # Mark the order as completed
            @order.update!(status: 'completed')
            puts "✅ Order successfully placed!"
            flash[:notice] = 'Order successfully placed!'
            redirect_to orders_path
          end
        else
          puts "❌ No pending order found!"
          redirect_to cart_path
        end
    rescue ActiveRecord::RecordInvalid => e
        flash[:error] = "Checkout failed: #{e.message}"
        redirect_to checkout_path
    end
end
  