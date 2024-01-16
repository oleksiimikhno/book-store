require 'swagger_helper'
require 'ffaker'

RSpec.describe 'api/v1/carts', type: :request do
  let(:cart) { create(:cart) }
  let(:user_id) { User.find(cart.user_id).id }
  let(:Authorization) { "Bearer #{generate_jwt_token(User.find(user_id))}" }

  path '/api/v1/carts' do

    get('list carts') do
      tags 'Carts'
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

    post('create cart') do
      tags 'Carts'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :cart, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/cart' }]
      }

      response(201, 'successful') do
        schema oneOf: [{ '$ref' => '#/components/schemas/cart' }]

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

  path '/api/v1/carts/{id}' do
    let(:id) { cart.id }

    parameter name: :id, in: :path, type: :integer, description: 'ID of the cart'

    get('show cart') do
      tags 'Carts'
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

    patch('update cart') do
      tags 'Carts'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :cart, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/cart' }]
      }

      response(200, 'successful') do
        schema oneOf: [{ '$ref' => '#/components/schemas/cart' }]

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
