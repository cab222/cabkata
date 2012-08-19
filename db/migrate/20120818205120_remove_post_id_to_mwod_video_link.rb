class RemovePostIdToMwodVideoLink < ActiveRecord::Migration
  def up
    remove_column :mwod_video_links, :post_id
  end

  def down
    add_column :mwod_video_links, :post_id, :integer
  end
end
