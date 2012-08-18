class CreateMwodPosts < ActiveRecord::Migration
  def change
    create_table :mwod_posts do |t|
      t.string :title
      t.date :date
      t.string :category
      t.timestamps
    end
  end
end
