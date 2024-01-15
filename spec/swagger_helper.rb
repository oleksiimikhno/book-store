# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://{bookStoreHost}',
          variables: {
            bookStoreHost: {
              default: 'book-store-api-tc-5855f695cf77.herokuapp.com'
            }
          }
        },
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: '127.0.0.1:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          category: {
            type: 'object',
            properties: {
              name: { type: :string },
              description: { type: :string },
              meta_title: { type: :string, nullable: true },
              meta_description: { type: :string, nullable: true },
            },
            required: %w[name]
          },
          product: {
            type: 'object',
            properties: {
              name: { type: :string },
              description: { type: :string },
              meta_title: { type: :string, nullable: true },
              meta_description: { type: :string, nullable: true },
              price: { type: :integer, default: 0 },
              quantity: { type: :integer, default: 0 },
              category_id: { type: :integer },
              status: { type: :string, enum: %w[active inactive archived], default: :active }
            },
            required: %w[name description]
          },
          cart: {
            type: 'object',
            properties: {
              status: { type: :string, enum: %w[unpaid paid canceled], default: :unpaid }
            }
          },
          cart_item: {
            type: 'object',
            properties: {
              quantity: { type: :integer, default: 0 },
              price: { type: :float, default: 0.0 }
            }
          },
          user: {
            type: 'object',
            properties: {
              first_name: { type: :string },
              last_name: { type: :string },
              email: { type: :string },
              password: { type: :string }
            },
            required: %w[first_name last_name email password]
          },
          user_response: {
            type: 'object',
            properties: {
              first_name: { type: :string },
              last_name: { type: :string },
              email: { type: :string },
              password: { type: :string },
              token: { type: :string },
              expires: { type: :string }
            }
          },
          session: {
            type: 'object',
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: %w[email password]
          },
          password_update: {
            type: 'object',
            properties: {
              old_password: { type: :string },
              password: { type: :string }
            },
            required: %w[old_password password]
          },
        },
        securitySchemes: {
          Bearer: {
            type: :http,
            scheme: :bearer,
            name: 'Authorization',
            in: :header,
            description: 'Your Bearer token'
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
