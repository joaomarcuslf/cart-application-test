require 'rails_helper'

RSpec.describe CatalogController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #product" do
    before :each do
      @product = FactoryBot.create(:product)
      
      get(:product,  params: { id: 0 })
    end
    
    it "returns http redirect" do     
      expect(response).to have_http_status(:redirect)
    end
    
    describe "session cart" do
      it "should have one size" do
        expect(session[:cart]['size']).to be 1
      end
      
      it "should have one product" do
        expect(session[:cart]['0']['quant']).to be 1
      end
      
      it "should have two products and size 2" do
        get(:product,  params: { id: 0 })
        expect(session[:cart]['0']['quant']).to be 2
        expect(session[:cart]['size']).to be 2
      end
    end
  end
end
