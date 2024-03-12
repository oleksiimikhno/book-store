require 'swagger_helper'

RSpec.describe "Api::V1::Fields", type: :request do
  let(:field) { create(:field) }
  let(:id) { field.id }
  let(:label) { Label.find(field.label_id) }
  let(:label_id) { field.label_id }
  let(:product) { Product.find(field.product_id) }
  let(:product_id) { field.product_id }
  let(:user) { create(:user) }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/labels/{label_id}/fields' do
    parameter name: :label_id, in: :path, type: :integer, description: 'label_id'
    parameter name: :product_id, in: :query, type: :integer, description: 'product_id', required: true

    before do
      product.labels << label
    end

    get('show fields list') do
      tags 'Fields'
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

    post('create fields') do
      tags 'Fields'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :field, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/field' }]
      }

      response(201, 'product created') do
        schema oneOf: [{ '$ref' => '#/components/schemas/field' }]

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

  path '/api/v1/labels/{label_id}/fields/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'id'
    parameter name: :label_id, in: :path, type: :integer, description: 'label_id'
    parameter name: :product_id, in: :query, type: :integer, description: 'product_id', required: true

    before do
      product.labels << label
    end

    get('show field') do
      tags 'Fields'
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

    patch('update field') do
      tags 'Fields'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :field, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/field' }]
      }

      response(200, 'successful') do
        schema oneOf: [{ '$ref' => '#/components/schemas/field' }]
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

    delete('delete field') do
      tags 'Fields'
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
