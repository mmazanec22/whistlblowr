class AddPinToComplaints < ActiveRecord::Migration[5.0]
  def change
    add_column :complaints, :pin, :string
  end
end
