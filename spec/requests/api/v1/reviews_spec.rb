require 'swagger_helper'

RSpec.describe 'api/v1/reviews', type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:review) { create(:review) }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/products/{product_id}/reviews' do
    parameter name: 'product_id', in: :path, type: :string, description: 'product_id'

    get('product list reviews') do
      tags 'Reviews'
      response(200, 'successful') do
        produces 'application/json'

        let(:product_id) { product.id }

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

    post('product create review') do
      tags 'Reviews'
      response(201, 'successful') do
        consumes 'application/json'
        produces 'application/json'
        security [Bearer: []]

        let(:product_id) { product.id }

        parameter name: :review, in: :body, schema: {
          oneOf: [{ '$ref' => '#/components/schemas/review' }]
        }

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
