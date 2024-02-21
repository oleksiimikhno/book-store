class AddFirstnameToSubscription < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :first_name, :string
  end
end
