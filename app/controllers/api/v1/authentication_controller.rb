class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authorize_request

  def login
    # render_success
  end
end
