class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    # Filter by category if a category is selected
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Filter by search query if provided
    if params[:query].present?
      @products = @products.where("name ILIKE ?", "%#{params[:query]}%")
    end

    # Paginate the products
    @products = @products.page(params[:page]).per(5)
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @order = current_user.orders.find_or_create_by(status: 'pending') do |order|
      order.total_price = 0
    end

    # Find or initialize order_item with the specified product
    order_item = @order.order_items.find_or_initialize_by(product: @product)
    
    # If the item already exists in the cart, add to the existing quantity
    if order_item.persisted?
      order_item.quantity += params[:quantity].to_i
    else
      order_item.assign_attributes(order_item_params)
    end

    if order_item.save
      @order.total_price = @order.order_items.sum { |item| item.quantity * item.unit_price }
      @order.save!

      puts "✅ Order item saved successfully!"
      redirect_to cart_path
    else
      puts "❌ Failed to save order item"
      puts "🔴 Error messages: #{order_item.errors.full_messages}"
      render :show, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  private

  def order_item_params
    params.permit(:quantity, :unit_price)
  end
end