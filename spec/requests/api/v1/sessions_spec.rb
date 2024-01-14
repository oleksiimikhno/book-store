require 'rails_helper'

RSpec.describe 'api/v1/sessions', type: :request do
  let(:user) { create(:user) }
  let(:login) { { email: user.email, password: user.password } }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/login' do
    post('login') do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :login, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/session' }]
      }

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

      response(401, 'unauthorized') do
        let(:login) { { email: 'invalid@invalid.com', password: 'invalid' } }

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
