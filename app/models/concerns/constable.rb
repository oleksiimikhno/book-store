# frozen_string_literal: true

module Constable
  extend ActiveSupport::Concern

  NAME_LENGTH = 2..30
  EMAIL_LENGTH = 8..64

  REGEXP_USER = /\A[a-zA-Z]+\z/
  REGEXP_EMAIL = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/
  REGEXP_PASSWORD = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]+\z/
end
