require 'admin_search_ransack'

class Admin::Api::V1::ProductsController < ApplicationController
  include AdminSearchRansack

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    q = Product.search(ransack_params(params)).result
    @products = q.paginate(page: params[:page], per_page: params[:per_page])
    render json: @products, meta: {total: q.count}
  end

  def show
    render json: @product
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product
    else
      render json: {}, status: 422
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: {}, status: 422
    end
  end

  def destroy
    @product.destroy
    render status: 204, nothing: true
  end

  def autocomplete
    q = Product.search(ransack_automplete_params(:title, params[:q])).result
    autocomplition = q.map { |product| {'value' => product.title} }
    render json: autocomplition, root: false
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :price, :company_id, :user_id, :is_active)
    end
end
