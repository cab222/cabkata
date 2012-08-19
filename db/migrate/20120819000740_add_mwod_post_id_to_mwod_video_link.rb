class AddMwodPostIdToMwodVideoLink < ActiveRecord::Migration
  def change
    add_column :mwod_video_links, :mwod_post_id, :integer
  end
end
