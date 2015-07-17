require 'rails_helper'


RSpec.describe Admin::Api::V1::UsersController, :type => :controller do

  let(:valid_attributes) {
    {
      email: "some@some.com"
    }
  }
 
  describe "GET index" do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      get :index
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, {:id => user.to_param}
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new user" do
        expect {
          post :create, {:user => valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { email: "new@new.com" }
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => new_attributes}
        user.reload
        expect(User.last.email).to eq(new_attributes[:email])
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, {:id => user.to_param}
      }.to change(User, :count).by(-1)
    end
  end

end
