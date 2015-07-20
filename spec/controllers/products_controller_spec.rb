require 'rails_helper'

RSpec.describe Admin::Api::V1::ProductsController, :type => :controller do

  let(:valid_attributes) {
    {
      title_en: "Product",
      title_de: "Ich product",
      title_fr: "La producte",
      title_ru: "Продукт",
      price: "220.33"
    }
  }
 
  describe "GET index" do
    it "assigns all products as @products" do
      product = FactoryGirl.create(:product)
      get :index
      expect(assigns(:products)).to eq([product])
    end
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      product = FactoryGirl.create(:product)
      get :show, {:id => product.to_param}
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, {:product => valid_attributes}
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes}
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { 
          title_en: "Product 1",
          title_de: "Ich product 1",
          title_fr: "La producte 1",
          title_ru: "Продукт 1", 
          price: "36" 
        }
      }

      it "updates the requested product" do
        product = FactoryGirl.create(:product)
        put :update, {:id => product.to_param, :product => new_attributes}
        product.reload
        expect(Product.last.title_en).to eq(new_attributes[:title_en])
        expect(Product.last.title_ru).to eq(new_attributes[:title_ru])
        expect(Product.last.title_de).to eq(new_attributes[:title_de])
        expect(Product.last.title_fr).to eq(new_attributes[:title_fr])
        expect(Product.last.price).to eq(new_attributes[:price].to_i)
      end

      it "assigns the requested product as @product" do
        product = FactoryGirl.create(:product)
        put :update, {:id => product.to_param, :product => valid_attributes}
        expect(assigns(:product)).to eq(product)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested product" do
      product = Product.create
      expect {
        delete :destroy, {:id => product.to_param }
      }.to change(Product, :count).by(-1)
    end
  end

end
