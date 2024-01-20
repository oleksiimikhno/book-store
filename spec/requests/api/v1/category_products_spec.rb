require 'swagger_helper'

RSpec.describe 'api/v1/products', type: :request do
  let(:product) { create(:product) }
  let(:id) { product.id }
  let(:category_id) { product.category_id }

  path '/api/v1/categories/{category_id}/products' do
    parameter name: :category_id, in: :path, type: :integer, description: 'category_id'

    get('show category products list') do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :order, in: :query, type: :string, description: 'sort products by orders "desc" and "asc"',
                enum: %w[desc asc], default: :desc

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

    post('create product in category') do
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
end
