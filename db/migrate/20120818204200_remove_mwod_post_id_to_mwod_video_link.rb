class RemoveMwodPostIdToMwodVideoLink < ActiveRecord::Migration
  def up
    remove_column :mwod_video_links, :mwod_post_id
  end

  def down
    add_column :mwod_video_links, :mwod_post_id, :integer
  end
end
