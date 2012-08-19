class RemoveLinkIdToMwodVideoLink < ActiveRecord::Migration
  def up
    remove_column :mwod_video_links, :link_id
  end

  def down
    add_column :mwod_video_links, :link_id, :integer
  end
end
