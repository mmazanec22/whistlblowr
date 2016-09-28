class AddCascadeDeleteToVideoLinks < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :video_links, :complaints
    add_foreign_key :video_links, :complaints, on_delete: :cascade
  end
end
