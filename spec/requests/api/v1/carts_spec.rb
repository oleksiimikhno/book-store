require 'swagger_helper'
require 'ffaker'

RSpec.describe 'api/v1/carts', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:cart) { user.carts.create }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/carts' do
    parameter name: :user_id, in: :query, type: :integer, description: 'ID of the user'

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

    parameter name: :user_id, in: :query, type: :integer, description: 'ID of the user'
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

    delete('delete cart') do
      tags 'Carts'
      consumes 'application/json'
      produces 'application/json'

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
