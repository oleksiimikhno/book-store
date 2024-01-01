# frozen_string_literal: true

class Api::V1::ProductsController < ApplicationController
  def index
    render json: { foo: 'bar' }
  end
end
