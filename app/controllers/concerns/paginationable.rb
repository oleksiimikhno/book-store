# frozen_string_literal: true

module Paginationable
  extend ActiveSupport::Concern

  private

  def limit_params
    params[:limit].to_i.positive? ? params[:limit].to_i : 20
  end
end
