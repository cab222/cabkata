class AddLinkToMwodVideoLinks < ActiveRecord::Migration
  def change
    add_column :mwod_video_links, :link, :string
  end
end
