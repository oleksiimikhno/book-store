require 'swagger_helper'

RSpec.describe 'api/v1/favorites', type: :request do
  let(:favorite) { create(:favorite) }
  let(:user) { favorite.user }
  let(:product) { favorite.product }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/favorites' do
    get('list favorites') do
      tags 'Favorite'
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

    post('create favorite') do
      tags 'Favorite'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :favorite, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/favorite' }]
      }

      response(201, 'successful') do
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

    delete('destroy favorite') do
      tags 'Favorite'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :favorite, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/favorite' }]
      }

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
