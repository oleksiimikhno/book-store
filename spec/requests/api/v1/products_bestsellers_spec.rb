require 'swagger_helper'

RSpec.describe 'api/v1/products_bestsellers', type: :request do
  path '/api/v1/products_bestsellers' do
    get('Bestsellers products') do
      tags 'Products'
      produces 'application/json'

      let(:filter) { 'author=marko' }
      let(:status) { 'bestseller' }
      let(:author_name) { 'author_name' }
      let(:price_start) { 100 }
      let(:price_end) { 300 }

      parameter name: :filter, in: :query, type: :string,
                description: 'filter by attributes query of the attrubutes is "author=marko;format=paper".
                Filter splited by ";" and has a key and a value where key=value query parameter'
      parameter name: :status, in: :query, type: :string, enum: %w[bestseller awaiting],
                description: 'filter by status default: [bestsellers awaiting sales]'
      parameter name: :author_name, in: :query, type: :string, description: 'filter by author name'
      parameter name: :price_start, in: :query, type: :string, description: 'filter by price start'
      parameter name: :price_end, in: :query, type: :string, description: 'filter by price end'

      let(:limit) { 20 }
      let(:order) { 'desc' }
      let(:price) { 'desc' }
      let(:rating) { 'desc' }

      parameter name: :limit, in: :query, type: :integer, default: 20, nullable: true,
                description: 'limit items per page'
      parameter name: :order, in: :query, type: :string, enum: %w[desc asc], default: :desc, nullable: true,
                description: 'sort products by orders "desc" and "asc"'
      parameter name: :price, in: :query, type: :string, enum: %w[desc asc], default: :desc, nullable: true,
                description: 'sort products by price "desc" and "asc"'
      parameter name: :rating, in: :query, type: :string, enum: %w[desc asc], default: :desc, nullable: true,
                description: 'sort products by rating "desc" and "asc"'

      response(200, 'successful') do
        header 'current-page', schema: { type: :integer }, description: 'The number of current page paggination'
        header 'link', schema: { type: :string }, description: 'The page links of the next and previous pages'
        header 'page-items', schema: { type: :integer }, description: 'The items per page'
        header 'total-count', schema: { type: :integer }, description: 'The total of all items'
        header 'total-pages', schema: { type: :integer }, description: 'The total of all pages'
        header 'min-price', schema: { type: :integer }, description: 'Min. price of all items'
        header 'max-price', schema: { type: :integer }, description: 'Max. price  of all items'

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
