require 'admin_search_ransack'

class Admin::Api::V1::CategoriesController < ApplicationController
  include AdminSearchRansack

  before_action :set_category, only: [:show, :update, :destroy, :rebuild]

  def index
    categories = []

    # ping https://github.com/steveklabnik for this issue in active_model_serializers gem

    Category.roots.each do |category|
      categories_json = CategorySerializer.new(category).as_json
      categories << categories_json['categories']
      categories << categories_json[:category] if categories_json[:category]
    end

    render json: {categories: categories.flatten}, meta: {total: Category.count}
  end

  def show
    render json: @category
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category
    else
      render json: {}, status: 422
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: {}, status: 422
    end
  end

  def destroy
    @category.destroy
    render status: 204, nothing: true
  end

  def autocomplete
    q = Category.search(ransack_automplete_params(:name, params[:q])).result
    autocomplition = q.map { |category| {'value' => category.name} }
    render json: autocomplition, root: false
  end

  def rebuild
    parent_id = params[:parent_id].to_i
    prev_id = params[:prev_id].to_i
    next_id = params[:next_id].to_i
    head(:bad_request) and return if parent_id.zero? && prev_id.zero? && next_id.zero?
    if prev_id.zero? && next_id.zero?
      @category.move_to_child_of Category.find(parent_id)
    elsif !prev_id.zero?
      @category.move_to_right_of Category.find(prev_id)
    elsif !next_id.zero?
      @category.move_to_left_of Category.find(next_id)
    end

    render json: @category, serializer: CategorySerializer
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
