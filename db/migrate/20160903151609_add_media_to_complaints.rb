class AddMediaToComplaints < ActiveRecord::Migration[5.0]
  def change
    add_column :complaints, :media, :json
  end
end
