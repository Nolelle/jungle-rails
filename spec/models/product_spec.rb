require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'tests for sucessfuly save of newly created product and category' do
      @category = Category.create(name: 'Shoes')
      @product =
        Product.create(
          name: 'product',
          price_cents: 300,
          quantity: 1,
          category: @category,
        )
      expect(@product.errors.any?).to eq(false)
    end
    it 'checks if a error message is present when there is no name field' do
      @category = Category.create(name: 'Shoes')
      @product =
        Product.create(
          price: 10_000,
          quantity: 1,
          category: @category,
          name: nil,
        )
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'checks if a error message is present when there is no price field' do
      @category = Category.create(name: 'Shoes')
      @product =
        Product.create(
          name: 'Joe',
          quantity: 1,
          category: @category,
          price: nil,
        )
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'checks if a error message is present when there is no quantity field' do
      @category = Category.create(name: 'Shoes')
      @product =
        Product.create(
          name: 'Joe',
          price: 10_000,
          category: @category,
          quantity: nil,
        )
      expect(@product.errors.full_messages).to include(
        "Quantity can't be blank",
      )
    end
    it 'checks if a error message is present when there is no category field' do
      @category = Category.create(name: 'Shoes')
      @product =
        Product.create(name: 'Joe', price: 10_000, quantity: 1, category: nil)
      expect(@product.errors.full_messages).to include(
        "Category can't be blank",
      )
    end
  end
end
