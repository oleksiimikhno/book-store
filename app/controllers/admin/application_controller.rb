# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    around_action :skip_bullet, if: -> { defined?(Bullet) }

    # TODO maybe need update authenticate
    # before_action :authenticate_admin
    #
    # def authenticate_admin
    # end

    http_basic_authenticate_with(
      name: Rails.application.credentials.dig(:admin_name),
      password: Rails.application.credentials.dig(:admin_password)
    )

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    def skip_bullet
      previous_value = Bullet.enable?
      Bullet.enable = false
      yield
    ensure
      Bullet.enable = previous_value
    end
  end
end
