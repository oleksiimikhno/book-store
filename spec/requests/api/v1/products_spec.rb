require 'swagger_helper'

RSpec.describe 'api/v1/products', type: :request do
  let(:product) { create(:product) }

  path '/api/v1/products' do
    get('list products') do
      tags 'Products'
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

    post('create product') do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'

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

  path '/api/v1/products/{id}' do
    let(:id) { product.id }

    parameter name: :id, in: :path, type: :integer, description: 'id'

    get('show product') do
      tags 'Products'
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

    patch('update product') do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :product, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/product' }]
      }

      response(200, 'successful') do
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

    delete('delete product') do
      tags 'Products'
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
