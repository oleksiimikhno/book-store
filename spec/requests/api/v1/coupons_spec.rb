
require 'swagger_helper'

RSpec.describe 'api/v1/coupons', type: :request do
  let(:coupon) { create(:coupon) }
  let(:user) { coupon.user }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }

  path '/api/v1/coupon' do
    get('show coupon') do
      tags 'Coupon'
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

  path '/api/v1/coupons' do
    post('create coupons') do
      tags 'Coupon'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        oneOf: [{ '$ref' => '#/components/schemas/coupon' }]
      }

      response(201, 'successful') do
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
