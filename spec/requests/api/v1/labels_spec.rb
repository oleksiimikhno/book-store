require 'swagger_helper'

RSpec.describe "Api::V1::Labels", type: :request do
  let(:label) { create(:label) }
  let(:id) { label.id }
  let(:user) { create(:user) }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/labels' do
    get('show labels list') do
      tags 'Labels'
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

    post('create label') do
      tags 'Labels'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :label, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/label' }]
      }

      response(201, 'product created') do
        schema oneOf: [{ '$ref' => '#/components/schemas/label' }]

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

  path '/api/v1/labels/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'id'

    get('show label') do
      tags 'Labels'
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

    patch('update label') do
      tags 'Labels'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :label, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/label' }]
      }

      response(200, 'successful') do
        schema oneOf: [{ '$ref' => '#/components/schemas/label' }]
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

    delete('delete label') do
      tags 'Labels'
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
