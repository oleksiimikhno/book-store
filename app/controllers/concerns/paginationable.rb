# frozen_string_literal: true

module Paginationable
  extend ActiveSupport::Concern

  private

  def limit_params
    @limit = params[:limit].to_i.positive? ? params[:limit].to_i : 20
  end
end
