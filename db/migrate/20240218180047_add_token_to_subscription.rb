class AddTokenToSubscription < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :token, :string
    add_index :subscriptions, :token, unique: true
  end
end
