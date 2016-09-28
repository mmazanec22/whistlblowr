class DropAllegationTypesTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :allegation_types
  end
end
