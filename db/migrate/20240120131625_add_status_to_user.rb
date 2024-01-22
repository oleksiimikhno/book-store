class AddStatusToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users,:status, :integer, default: 0, null: false
  end

  def down
    remove_column :users, :status
  end
end
