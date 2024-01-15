require 'swagger_helper'

RSpec.describe 'api/v1/categories', type: :request do
  let(:category) { create(:category) }
  let(:id) { category.id }

  path '/api/v1/categories' do
    get('list categories') do
      tags 'Categories'
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

    post('create category') do
      tags 'Categories'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :category, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/category' }]
      }

      response(201, 'successful') do
        schema oneOf: [{ '$ref' => '#/components/schemas/category' }]

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

  path '/api/v1/categories/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show category') do
      tags 'Categories'
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

    patch('update category') do
      tags 'Categories'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :category, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/category' }]
      }

      response(200, 'successful') do
        schema oneOf: [{ '$ref' => '#/components/schemas/category' }]

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

    delete('delete category') do
      tags 'Categories'
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
