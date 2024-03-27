require 'rails_helper'

RSpec.describe "Api::V1::Filters", type: :request do
  path '/api/v1/filter_product' do
    get('filter product by author') do
      tags 'Filter'
      produces 'application/json'

      let(:author_name) { 'author_name' }
      let(:limit) { 20 }

      parameter name: :limit, in: :query, type: :integer, default: 20, nullable: true,
                description: 'limit items per page'

      parameter name: :author_name, in: :query, type: :string, required: true

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

      response(422, 'unprocessable_entity') do
        let(:author_name) { nil }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['errors']).to eq('Author name parameter is required!')
        end
      end
    end
  end
end
