require 'rails_helper'

RSpec.describe Product, type: :model do
  it "should not be accepted without name or price" do
    product = Product.new(name: nil, price: nil)
    expect(product).to_not be_valid
  end

  it "should not be accepted without name" do
    product = Product.new(name: nil, price: 0.20)
    expect(product).to_not be_valid
  end

  it "should not be accepted without price" do
    product = Product.new(name: 'Test Name', price: nil)
    expect(product).to_not be_valid
  end

  it "should be accepted when both fields are filled" do
    product = Product.new(name: 'Test Name', price: 0.20)
    expect(product).to be_valid
  end

  it "should not be accepted duplicated products" do
    product = Product.new(name: 'Test Name', price: 0.20)
    product.save()
    product1 = Product.new(name: 'Test Name', price: 0.20)
    expect(product).to be_valid
    expect(product1).to_not be_valid
  end
end
