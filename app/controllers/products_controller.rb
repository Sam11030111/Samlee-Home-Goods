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
end