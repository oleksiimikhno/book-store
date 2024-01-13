require 'rails_helper'

RSpec.describe 'api/v1/authentications', type: :request do
  let(:user) { create(:user) }
  let(:login) { { email: user.email, password: user.password } }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/login' do
    post('login') do
      tags 'Authentications'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :login, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/login' }]
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

  path '/api/v1/update_password' do
    post('update_password') do
      tags 'Authentications'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      let(:update_password) { { old_password: user.password, password: 'Weww21Wqweqweqw' } }

      parameter name: :update_password, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/update_password' }]
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
        let(:update_password) { { old_password: 'indalid_password', password: 'invalid' } }

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
