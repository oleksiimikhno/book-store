class AddNameToSubscription < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :name, :string
  end
end
