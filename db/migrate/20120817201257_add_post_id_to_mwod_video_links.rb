class AddPostIdToMwodVideoLinks < ActiveRecord::Migration
  def change
    add_column :mwod_video_links, :post_id, :integer
  end
end
