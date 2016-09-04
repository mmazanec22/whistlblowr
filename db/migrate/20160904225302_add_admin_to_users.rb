class AddAdminToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :investigators, :admin, :boolean, default: false
  end
end
