class AddVideoLinksToComplaints < ActiveRecord::Migration[5.0]
  def change
    add_column :complaints, :video_links, :string
  end
end
