class RemovePostIdToMwodPost < ActiveRecord::Migration
  def up
    remove_column :mwod_posts, :post_id
  end

  def down
    add_column :mwod_posts, :post_id, :integer
  end
end
