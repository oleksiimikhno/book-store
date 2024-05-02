require 'rails_helper'

RSpec.describe 'api/v1/search', type: :request do
  path '/api/v1/search' do
    get('search products with a title and a description') do
      tags 'Search'
      produces 'application/json'

      let(:query) { 'qwery' }
      let(:limit) { 20 }
      let(:order) { 'desc' }
      let(:price) { 'desc' }

      parameter name: :limit, in: :query, type: :integer, default: 20, nullable: true,
                description: 'limit items per page'
      parameter name: :order, in: :query, type: :string, enum: %w[desc asc], default: :desc, nullable: true,
                description: 'sort products by newest/oldest "desc" and "asc"'
      parameter name: :price, in: :query, type: :string, enum: %w[desc asc], default: :desc, nullable: true,
                description: 'sort products by price "desc" and "asc"'

      parameter name: :query, in: :query, type: :string

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

      response(422, 'unprocessable_entity') do
        let(:query) { 'qw' }

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
