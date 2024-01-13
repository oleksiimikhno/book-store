require 'rails_helper'

RSpec.describe 'api/v1/passwords', type: :request do
  let(:user) { create(:user) }
  let(:login) { { email: user.email, password: user.password } }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/password_update' do
    post('password update') do
      tags 'Passwords'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      let(:password_update) { { old_password: user.password, password: 'Weww21Wqweqweqw' } }

      parameter name: :password_update, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/password_update' }]
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

      response(406, 'unauthorized') do
        let(:password_update) { { old_password: 'indalid_password', password: 'invalid' } }

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
