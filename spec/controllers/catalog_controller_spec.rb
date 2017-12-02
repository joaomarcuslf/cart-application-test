require 'rails_helper'

RSpec.describe CatalogController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #product" do
    it "returns http success" do
      get :product
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #cart" do
    it "returns http success" do
      get :cart
      expect(response).to have_http_status(:success)
    end
  end

end
