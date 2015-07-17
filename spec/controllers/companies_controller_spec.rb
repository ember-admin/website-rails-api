require 'rails_helper'

RSpec.describe Admin::Api::V1::CompaniesController, :type => :controller do

  let(:valid_attributes) {
    {
      title: "Company"
    }
  }
 
  describe "GET index" do
    it "assigns all companies as @companies" do
      company = Company.create! valid_attributes
      get :index
      expect(assigns(:companies)).to eq([company])
    end
  end

  describe "GET show" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :show, {:id => company.to_param}
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, {:company => valid_attributes}
        }.to change(Company, :count).by(1)
      end

      it "assigns a newly created company as @company" do
        post :create, {:company => valid_attributes}
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { title: "New title" }
      }

      it "updates the requested company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => new_attributes}
        company.reload
        expect(Company.last.title).to eq(new_attributes[:title])
      end

      it "assigns the requested company as @company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => valid_attributes}
        expect(assigns(:company)).to eq(company)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested company" do
      company = Company.create! valid_attributes
      expect {
        delete :destroy, {:id => company.to_param}
      }.to change(Company, :count).by(-1)
    end
  end

end
