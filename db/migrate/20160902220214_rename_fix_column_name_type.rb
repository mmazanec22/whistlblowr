class RenameFixColumnNameType < ActiveRecord::Migration[5.0]
  def change
    rename_column :allegation_types, :type, :allegation_nature
  end
end
