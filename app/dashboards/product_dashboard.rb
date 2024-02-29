require 'administrate/base_dashboard'

class ProductDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    model: Field::String,
    image: Field::ActiveStorage.with_options(
      show_preview_size: [150, 150],
      destroy_url: proc do |namespace, resource, attachment|
        [:image_admin_product, { attachment_id: attachment.id }]
      end
    ),
    images: Field::ActiveStorage.with_options(
      show_preview_size: [150, 150], index_display_preview: false,
      destroy_url: proc do |namespace, resource, attachment|
        [:images_admin_product, { attachment_id: attachment.id }]
      end
    ),
    description: Field::Text,
    meta_description: Field::Text,
    meta_title: Field::String,
    price: Field::Number,
    special_price: Field::Number,
    quantity: Field::Number,
    status: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    category: Field::BelongsTo.with_options(class_name: 'Category'),
    labels: Field::HasMany.with_options(class_name: 'Label'),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    price
    quantity
    status
    category
    updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    description
    meta_description
    meta_title
    price
    quantity
    image
    status
    labels
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    model
    description
    meta_description
    meta_title
    price
    special_price
    quantity
    image
    images
    status
    category
    labels
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how products are displayed
  # across all pages of the admin dashboard.
  #

  def permitted_attributes(action)
    super + [:images => []]
  end

  def display_resource(product)
    "Product ##{product.id} - #{product.name} (Category: #{product.category.name})"
  end
end
