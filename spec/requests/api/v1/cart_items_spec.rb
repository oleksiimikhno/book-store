require 'swagger_helper'

RSpec.describe "Api::V1::CartItems", type: :request do
  let(:cart_item) { create(:cart_item) }
  let(:cart_id) { cart_item.cart_id }
  let(:user) { User.find(Cart.find(cart_id).user_id) }
  let(:product_id) { cart_item.product_id }
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
