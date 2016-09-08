class RemoveUsernameFromInvestigators < ActiveRecord::Migration[5.0]
  def change
    change_table :investigators do |t|
      t.remove :username
    end
  end
end
