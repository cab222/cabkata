class AddPostIdToMwodPost < ActiveRecord::Migration
  def change
    add_column :mwod_posts, :post_id, :integer
  end
end
