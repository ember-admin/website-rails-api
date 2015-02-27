require 'file_string_io'

class Admin::Api::V1::ProductImagesController < ApplicationController

  def index
    product_images = ProductImage.paginate(page: params[:page], per_page: params[:per_page]).order('id desc')
    render json: product_images, each_serialzier: ProductImageSerializer
  end

  def destroy
    ProductImage.find_by_id(params[:id]).try(:destroy)
    render status: 204, nothing: true
  end

  def show
    render json: ProductImage.find(params[:id]), serialize: ProductImageSerializer
  end

  def create
    product_image = ProductImage.new(fetch_params)
    file = FileStringIO.new(request.raw_post, params[:original_filename])
    product_image.data = file
    product_image.save!
    render json: product_image, serialize: ProductImageSerializer
  end

  def update
    product_image = ProductImage.find(params[:id])
    product_image.update_attributes(permit_params)
    render json: product_image, serialize: ProductImageSerializer
  end

  private

  def permit_params
    options = params.require(:product_image).permit(:id, :assetable_id, :assetable_type, :guid, :type, :data, :position, :content_type)
    options.delete(:data) unless options[:data].present?
    options
  end

  def fetch_params
    options = {}
    [:assetable_id, :assetable_type, :guid, :type, :is_main, :position, :content_type].each do |param|
      options[param] = params[param]
    end
    options
  end

end