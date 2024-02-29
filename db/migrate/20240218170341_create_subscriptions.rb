class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.integer :status
      t.references :user

      t.timestamps
    end
  end
end
