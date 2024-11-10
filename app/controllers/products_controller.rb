class ProductsController < ApplicationController
  def index
    if params[:category_id]
      @products = Product.where(category_id: params[:category_id])
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end