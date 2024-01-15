require 'swagger_helper'

RSpec.describe "Api::V1::CartItems", type: :request do
  let(:user) { create(:user) }
  let(:cart) { user.carts.create }
  let(:cart_id) { cart.id }
  let(:product) { create(:product) }
  let(:product_id) { product.id }
  let(:cart_item) { cart.cart_items.create(product_id: product.id) }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/cart_items' do
    parameter name: :cart_id, in: :query, type: :integer, description: 'ID of the cart'
    parameter name: :product_id, in: :query, type: :integer, description: 'ID of the product'

    post('create cart_item') do
      tags 'CartItems'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :cart_item, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/cart_item' }]
      }

      response(201, 'successful') do
        schema oneOf: [{ '$ref' => '#/components/schemas/cart_item' }]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/cart_items/{id}' do
    let(:id) { cart_item.id }

    parameter name: :cart_id, in: :query, type: :integer, description: 'ID of the cart'
    parameter name: :product_id, in: :query, type: :integer, description: 'ID of the product'
    parameter name: :id, in: :path, type: :integer, description: 'ID of the cart_item'

    get('show cart_item') do
      tags 'CartItems'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update cart_lines') do
      tags 'CartItems'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :cart_item, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/cart_item' }]
      }

      response(200, 'successful') do
        schema oneOf: [{ '$ref' => '#/components/schemas/cart_item' }]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete cart_lines') do
      tags 'CartItems'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
