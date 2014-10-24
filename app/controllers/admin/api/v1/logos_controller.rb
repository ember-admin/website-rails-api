require 'file_string_io'

class Admin::Api::V1::LogosController < ApplicationController

  def index
    logos = Logo.paginate(page: params[:page], per_page: params[:per_page]).order('id desc')
    render json: logos, each_serialzier: LogoSerializer
  end

  def destroy
    Logo.find_by_id(params[:id]).try(:destroy)
    render status: 204, nothing: true
  end

  def show
    render json: Logo.find(params[:id]), serialize: LogoSerializer
  end

  def create
    logo = Logo.new(fetch_params)
    file = FileStringIO.new(request.raw_post, params[:original_filename])
    logo.data = file
    logo.save!
    render json: logo, serialize: LogoSerializer
  end

  def update
    logo = Logo.find(params[:id])
    logo.update_attributes(permit_params)
    render json: logo, serialize: LogoSerializer
  end

  private

  def permit_params
    options = params.require(:logo).permit(:id, :assetable_id, :assetable_type, :guid, :type, :data)
    options.delete(:data) unless options[:data].present?
    options
  end

  def fetch_params
    options = {}
    [:assetable_id, :assetable_type, :guid, :type, :is_main].each do |param|
      options[param] = params[param]
    end
    options
  end

end