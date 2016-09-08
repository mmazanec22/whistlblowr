class RemoveVideoLinksFromComplaint < ActiveRecord::Migration[5.0]
  def change
    remove_column :complaints, :video_links
  end
end
