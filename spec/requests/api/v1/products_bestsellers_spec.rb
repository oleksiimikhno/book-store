require 'swagger_helper'

RSpec.describe 'api/v1/products_bestsellers', type: :request do
  path '/api/v1/products_bestsellers' do
    get('Bestsellers products') do
      tags 'Products'
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
  end
end
