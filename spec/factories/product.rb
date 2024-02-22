# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :product do
    name { FFaker::Book.title[0, 50] }
    description { FFaker::Book.description }
    price { 5000 }
    discount { 400 }
    model { '123-23' }
    quantity { 1 }
    association :category, factory: :category

    # That fixture put random errors with pundit and category association, not always attached image.
    # Maybe should to remove this and fixtures files.

    # image { Rack::Test::UploadedFile.new('spec/fixtures/images/image.jpeg', 'image/jpeg') }
    # trait :with_image do
    #   before :create do |product|
    #     product.image.attach(
    #       io: Rack::Test::UploadedFile.new('spec/fixtures/images/image.jpeg', 'image/jpeg'),
    #       filename: 'image.jpg',
    #       content_type: 'image/jpeg'
    #     )
    #   end
    # end
  end
end
