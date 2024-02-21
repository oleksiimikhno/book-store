require 'swagger_helper'

RSpec.describe 'api/v1/products', type: :request do
  let(:product) { create(:product) }
  let(:id) { product.id }
  let(:user) { create(:user) }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/products' do
    get('list products') do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'

      let(:limit) { 20 }
      let(:order) { 'desc' }
      let(:price) { 'desc' }

      parameter name: :limit, in: :query, type: :integer, default: 20, nullable: true,
                description: 'limit items per page'
      parameter name: :order, in: :query, type: :string, enum: %w[desc asc], default: :desc, nullable: true,
                description: 'sort products by orders "desc" and "asc"'
      parameter name: :price, in: :query, type: :string, enum: %w[desc asc], default: :desc, nullable: true,
                description: 'sort products by price "desc" and "asc"'

      response(200, 'successful') do
        header 'current-page', schema: { type: :integer }, description: 'The number of current page paggination'
        header 'link', schema: { type: :string }, description: 'The page links of the next and previous pages'
        header 'page-items', schema: { type: :integer }, description: 'The items per page'
        header 'total-count', schema: { type: :integer }, description: 'The total of all items'
        header 'total-pages', schema: { type: :integer }, description: 'The total of all pages'

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

  path '/api/v1/products/{id}' do
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
      security [Bearer: []]

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
