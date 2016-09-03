class CreateComplaints < ActiveRecord::Migration[5.0]
  def change
    create_table :complaints do |t|
      t.string :key, null: false
      t.references :user, foreign_key: true
      t.text :content, null: false

      t.timestamps(null: false)
    end
  end
end
