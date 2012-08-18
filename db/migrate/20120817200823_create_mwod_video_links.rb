class CreateMwodVideoLinks < ActiveRecord::Migration
  def change
    create_table :mwod_video_links do |t|
      t.integer :link_id
      t.integer :mwod_post_id

      t.timestamps
    end
  end
end
