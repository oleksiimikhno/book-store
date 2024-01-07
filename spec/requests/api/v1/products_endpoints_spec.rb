# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products endpoints' do
  describe 'POST /api/v1/products' do
    context 'when all parameters are provided' do
      # TODO move the params to concerns
      params = {
        name: 'The Odd Sister',
        description: 'Throughout the Villains series',
        price: 5000,
        quantity: 1
      }

      it 'creates a product' do
        expect do
          post api_v1_products_url, params: params
        end.to change(Product, :count).by(1)
      end

      it 'presents the value given as params' do
        post api_v1_products_url, params: params
        product = Product.last

        expect(product.name).to eq('The Odd Sister')
        expect(product.description).to eq('Throughout the Villains series')
        expect(product.price).to eq(5000)
        expect(product.quantity).to eq(1)
        expect(product.status).to eq('active')
      end
    end

    context 'when price is negative' do
       # TODO move the params to concerns
      params = {
        name: 'The Odd Sister',
        description: 'Throughout the Villains series',
        price: -5000
      }

      it 'does not present the product' do
        expect do
          post api_v1_products_url, params: params
        end.not_to change(Product, :count)
      end
    end

    context 'when the product changes statuses' do
       # TODO move the params to concerns
      params = {
        name: 'The Odd Sister',
        description: 'Throughout the Villains series',
        status: 'inactive'
      }

      it 'is the product can change status' do
        post api_v1_products_url, params: params
        product = Product.last

        expect(product.status).to eq('inactive')
        product.status = 'archived'

        expect(product.status).to eq('archived')
      end
    end

    context 'when the product has meta texts' do
       # TODO move the params to concerns
      params = {
        name: 'The Odd Sister',
        description: 'Throughout the Villains series',
        meta_title: 'The Odd Sister: A Quirky Tale of Mysterious Bonds, Enigmatic Journeys, and Unraveling Secrets in a World of Words',
        meta_description: 'Dive into The Odd Sister, where familial mysteries collide with a whimsical world, unraveling secrets that weave a captivating'
      }

      it 'is the product has meta texts' do
        post api_v1_products_url, params: params
        product = Product.last

        expect(product.meta_title).to eq(params[:meta_title])
        expect(product.meta_description).to eq(params[:meta_description])
      end

      it 'when meta_title below 20 symbols' do
        params[:meta_title] = 'Throughout'

        expect do
          post api_v1_products_url, params: params
        end.not_to change(Product, :count)
      end

      it 'when meta_description below 60 symbols' do
        params[:meta_description] = 'Throughout'

        expect do
          post api_v1_products_url, params: params
        end.not_to change(Product, :count)
      end

      it 'when meta_title above 120 symbols' do
        params[:meta_title] = 'Throughout symbols Throughout symbols' * 5

        expect do
          post api_v1_products_url, params: params
        end.not_to change(Product, :count)
      end

      it 'when meta_description above 200 symbols' do
        params[:meta_description] = 'Throughout symbols Throughout symbols' * 5

        expect do
          post api_v1_products_url, params: params
        end.not_to change(Product, :count)
      end
    end
  end

  # TODO add test for the show method
  # TODO add test for the update method
  # TODO add test for the destroy method
  # TODO add test for the relations
end
