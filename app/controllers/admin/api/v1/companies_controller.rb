require 'admin_search_ransack'

class Admin::Api::V1::CompaniesController < ApplicationController
  include AdminSearchRansack

  before_action :set_company, only: [:show, :update, :destroy]

  def index
    q = Company.search(ransack_params(params)).result
    @companies = q.paginate(page: params[:page], per_page: params[:per_page])
    render json: @companies, meta: {total: q.count}
  end

  def show
    render json: @company
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      render json: @company
    else
      render json: {}, status: 422
    end
  end

  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: {}, status: 422
    end
  end

  def destroy
    @company.destroy
    render status: 204, nothing: true
  end


  def autocomplete
    q = Company.search(ransack_automplete_params(:title, params[:q])).result
    autocomplition = q.map { |company| {'value' => company.title} }
    render json: autocomplition, root: false
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:title, :id, :lat, :long, :zoom)
    end
end
