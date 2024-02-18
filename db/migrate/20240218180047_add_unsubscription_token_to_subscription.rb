class AddUnsubscriptionTokenToSubscription < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :unsubscription_token, :string
    add_index :subscriptions, :unsubscription_token, unique: true
  end
end
