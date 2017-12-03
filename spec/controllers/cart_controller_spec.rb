require 'rails_helper'

RSpec.describe CartController, type: :controller do
  before :each do
    @product = FactoryBot.create(:product)
    session[:cart] = {
      '0' => {
        'quant' => 1,
        'price' => 10.0
      },
      'size' => 1,
      'total' => 10.0
    }
  end
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "should remove a product from cart if it is invalid" do
      session[:cart] = {
        '0' => {
          'quant' => 1,
          'price' => 10.0
        },
        '1' => {
          'quant' => 1,
          'price' => 20.0
        },
        'size' => 2,
        'total' => 30.0
      }
      
      get :index
      expect(session[:cart]['size']).to be 1
    end
  end

  describe "GET #empty" do
    before :each do
      get :empty
    end
    
    it "returns http redirect" do
      expect(response).to have_http_status(:redirect)
    end
    
    it "should have a flash message" do
      expect(flash[:notice]).to_not be nil
    end
    
    it "should have a clean cart" do
      expect(session[:cart]['size']).to be 0
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
    
    it "should remove a product from cart if it is invalid" do
      session[:cart] = {
        '0' => {
          'quant' => 1,
          'price' => 10.0
        },
        '1' => {
          'quant' => 1,
          'price' => 20.0
        },
        'size' => 2,
        'total' => 30.0
      }
      
      get :index
      expect(session[:cart]['size']).to be 1
    end
  end
  
  describe "POST #update_cart" do
    before :each do
      @products = {
        '0' => {
          "'quant'" => 10
        }
      }
    end
    
    it "returns http redirect" do
      post(:update_cart, params: { products: @products })
      expect(response).to have_http_status(:redirect)
    end
    
    it "should update cart value" do
      expect(session[:cart]['0']['quant']).to be_equal 1
      post(:update_cart, params: { products: @products })
      expect(session[:cart]['0']['quant']).to be_equal 10
    end
    
    it "should remove a product from cart if it is invalid" do
      session[:cart] = {
        '0' => {
          'quant' => 1,
          'price' => 10.0
        },
        '1' => {
          'quant' => 1,
          'price' => 20.0
        },
        'size' => 2,
        'total' => 30.0
      }
      
      get :index
      expect(session[:cart]['size']).to be 1
    end
  end
  
  describe "GET #pre_purchase" do
    it "returns http success" do
      get :pre_purchase
      expect(response).to have_http_status(:success)
    end
    
    it "should remove a product from cart if it is invalid" do
      session[:cart] = {
        '0' => {
          'quant' => 1,
          'price' => 10.0
        },
        '1' => {
          'quant' => 1,
          'price' => 20.0
        },
        'size' => 2,
        'total' => 30.0
      }
      
      get :index
      expect(session[:cart]['size']).to be 1
    end
  end
  
  describe "POST #order" do
    # Should implement a better test for that
    before :each do
      post(:order, params: { username: "Test name" })
    end
    
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    it "should have a flash message" do
      expect(flash[:notice]).to_not be nil
    end
    
    it "should have a clean cart" do
      expect(session[:cart]['size']).to be 0
    end
    
    it "should remove a product from cart if it is invalid" do
      session[:cart] = {
        '0' => {
          'quant' => 1,
          'price' => 10.0
        },
        '1' => {
          'quant' => 1,
          'price' => 20.0
        },
        'size' => 2,
        'total' => 30.0
      }
      
      get :index
      expect(session[:cart]['size']).to be 1
    end
  end
end
