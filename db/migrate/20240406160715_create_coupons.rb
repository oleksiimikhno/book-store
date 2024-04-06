class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :first_name
      t.string :email
      t.integer :discount_value
      t.integer :status
      t.string :token
      t.references :user

      t.timestamps
    end
    add_index :coupons, :token, unique: true
  end
end
