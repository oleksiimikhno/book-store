require 'swagger_helper'

RSpec.describe '/api/v1/subscriptions', type: :request do
  let(:subscription) { create(:subscription) }
  let(:user) { subscription.user }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/subscription' do
    get('show subscription') do
      tags 'Subscriptions'
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

  path '/api/v1/subscriptions' do
    post('create subscription') do
      tags 'Subscriptions'
      consumes 'application/json'
      produces 'application/json'

      let(:user) { create(:user) }

      parameter name: :user, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/subscription' }]
      }

      response(201, 'subscription created') do
        schema oneOf: [{ '$ref' => '#/components/schemas/subscription' }]

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

  path '/api/v1/unsubscription' do
    delete('destroy subscription') do
      tags 'Subscriptions'
      produces 'application/json'

      let(:token) { subscription.token }

      parameter name: :token, in: :query, type: :string, description: 'Token for updating the status of a subscription'

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
