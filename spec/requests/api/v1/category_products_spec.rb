require 'swagger_helper'

RSpec.describe 'api/v1/products', type: :request do
  let(:product) { create(:product) }
  let(:id) { product.id }
  let(:category_id) { product.category_id }
  let(:user) { create(:user) }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/categories/{category_id}/products' do
    parameter name: :category_id, in: :path, type: :integer, description: 'category_id'

    get('show category products list') do
      tags 'Products'
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

    post('create product in category') do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :product, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/product' }]
      }

      response(201, 'product created') do
        schema oneOf: [{ '$ref' => '#/components/schemas/product' }]

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
