module Validateable
  extend ActiveSupport::Concern
  include Constable

  included do
    def self.validate_field(name, lenght = Constable::NAME_LENGTH)
      validates name, presence: true, length: { in: lenght }
    end

    def self.validate_field_can_be_empty(name, lenght = Constable::NAME_LENGTH)
      validates name, presence: true, length: { in: lenght }, allow_blank: true
    end

    def self.validate_field_positive_integer(name, lenght = 0)
      validates name, presence: true, numericality: { greater_than_or_equal_to: lenght }
    end

    def self.validate_field_presence(name)
      validates name, presence: true
    end
  end
end
