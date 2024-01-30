require 'rails_helper'

RSpec.describe 'api/v1/search', type: :request do
  let(:query) { 'qwery' }
  path '/api/v1/search' do
    get('search products with a title and a description') do
      tags 'Search'
      produces 'application/json'

      parameter name: :query, in: :query, type: :string

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
