require 'file_string_io'

class Admin::Api::V1::AvatarsController < ApplicationController

  def index
    avatars = Avatar.paginate(page: params[:page], per_page: params[:per_page]).order('id desc')
    render json: avatars, each_serialzier: AvatarSerializer
  end

  def destroy
    Avatar.find_by_id(params[:id]).try(:destroy)
    render status: 204, nothing: true
  end

  def show
    render json: Avatar.find(params[:id]), serialize: AvatarSerializer
  end

  def create
    avatar = Avatar.new(fetch_params)
    file = FileStringIO.new(request.raw_post, params[:original_filename])
    avatar.data = file
    avatar.save!
    render json: avatar, serialize: AvatarSerializer
  end

  def update
    avatar = Avatar.find(params[:id])
    avatar.update_attributes(permit_params)
    render json: avatar, serialize: AvatarSerializer
  end

  private

  def permit_params
    options = params.require(:avatar).permit(:id, :assetable_id, :assetable_type, :guid, :type, :data)
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