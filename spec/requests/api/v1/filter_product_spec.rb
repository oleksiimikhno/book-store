require 'rails_helper'

RSpec.describe "Api::V1::Filters", type: :request do
  path '/api/v1/filter_product' do
    get('filter product by author') do
      tags 'Filter'
      produces 'application/json'

      let(:limit) { 20 }

      parameter name: :limit, in: :query, type: :integer, default: 20, nullable: true,
                description: 'limit items per page'

      let(:author_name) { 'author_name' }
      let(:price_start) { 100 }
      let(:price_end) { 300 }

      parameter name: :author_name, in: :query, type: :string
      parameter name: :price_start, in: :query, type: :string
      parameter name: :price_end, in: :query, type: :string

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
