require 'admin_search_ransack'

class Admin::Api::V1::UsersController < ApplicationController
  include AdminSearchRansack

  before_action :set_user, only: [:show, :update, :destroy]

  def index
    q = User.search(ransack_params(params)).result
    @users = q.paginate(page: params[:page], per_page: params[:per_page])
    render json: @users, meta: {total: q.count}
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: {}, status: 422
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: {}, status: 422
    end
  end

  def destroy
    @user.destroy
    render status: 204, nothing: true
  end

  def autocomplete
    q = User.search(ransack_automplete_params(:email, params[:q])).result
    autocomplition = q.map { |user| {'value' => user.email} }
    render json: autocomplition, root: false
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :avatar)
    end
end
