# frozen_string_literal: true

module Constable
  extend ActiveSupport::Concern

  NAME_LENGTH = (2..50).freeze
  EMAIL_LENGTH = (8..64).freeze
  PASSWORD_LENGTH = (8..64).freeze
  DESCRIPTION_LENGTH = (3..2500).freeze
  MODEL_LENGTH = (3..25).freeze

  META_TITLE_LENGTH = (20..120).freeze
  META_DESCRIPTION_LENGTH = (60..200).freeze

  REGEXP_USER = /\A[a-zA-Zа-яА-Я\d.\s\S]+\z/.freeze
  REGEXP_EMAIL = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/.freeze
  REGEXP_PASSWORD = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/.freeze

  IMAGE_SIZE = (1.kilobyte..2.megabytes).freeze
  IMAGE_FORMATS = %i[png jpg jpeg webp].freeze
end
