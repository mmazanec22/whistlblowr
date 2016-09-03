class CreateAllegationTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :allegation_types do |t|
      t.string :type, null: false

      t.timestamps(null: false)
    end
  end
end
