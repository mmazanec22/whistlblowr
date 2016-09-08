class CreateVideoLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :video_links do |t|
      t.string :url, null: false
      t.references :complaint, foreign_key: true
    end
  end
end
