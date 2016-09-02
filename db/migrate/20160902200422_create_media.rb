class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.references :complaint, foreign_key: true
      t.string :media_type, null: false
      t.string :url, null: false
      t.string :description

      t.timestamps(null: false)
    end
  end
end
