require 'rails_helper'

RSpec.describe Admin::Api::V1::CategoriesController, :type => :controller do

  let(:valid_attributes) {
    {
      name: "Category"
    }
  }
 
  describe "GET show" do
    it "assigns the requested category as @category" do
      category = FactoryGirl.create(:category)
      get :show, {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new category" do
        expect {
          post :create, {:category => valid_attributes}
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => valid_attributes}
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { name: "New name" }
      }

      it "updates the requested category" do
        category = FactoryGirl.create(:category)
        put :update, {:id => category.to_param, :category => new_attributes}
        category.reload
        expect(Category.last.name).to eq(new_attributes[:name])
      end

      it "assigns the requested category as @category" do
        category = FactoryGirl.create(:category)
        put :update, {:id => category.to_param, :category => valid_attributes}
        expect(assigns(:category)).to eq(category)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = FactoryGirl.create(:category)
      expect {
        delete :destroy, {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end
  end

end