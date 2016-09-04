class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text    :text
      t.integer :complaint_id
      t.integer :messageable_id
      t.string  :messageable_type
      t.timestamps
    end
  end
end
