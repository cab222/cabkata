class AddDescriptionToMwodPost < ActiveRecord::Migration
  def change
    add_column :mwod_posts, :description, :string
  end
end
