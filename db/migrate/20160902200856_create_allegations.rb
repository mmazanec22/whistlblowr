class CreateAllegations < ActiveRecord::Migration[5.0]
  def change
    create_table :allegations do |t|
      t.references :complaint, foreign_key: true
      t.references :allegation_type, foreign_key: true

      t.timestamps(null:false)
    end
  end
end
