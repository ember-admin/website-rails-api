require 'admin_search_ransack'

class Admin::Api::V1::CategoriesController < ApplicationController
  include AdminSearchRansack

  before_action :set_category, only: [:show, :update, :destroy]

  def index
    q = Category.search(ransack_params(params)).result
    categories = q.paginate(page: params[:page], per_page: params[:per_page])
    render json: categories, meta: {total: q.count}
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
    if params[:category][:prev_id].present? || params[:category][:next_id].present? || params[:category][:parent].present?
      return rebuild
    end
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

  private

  def rebuild
    parent_id = params[:category][:parent].to_i
    prev_id = params[:category][:prev_id].to_i
    next_id = params[:category][:next_id].to_i
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

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end