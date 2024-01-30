require 'rails_helper'

RSpec.describe 'api/v1/search', type: :request do
  path '/api/v1/search' do
    get('search products with a title and a description') do
      tags 'Search'
      produces 'application/json'

      parameter name: 'search text', in: :query, type: :string

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
