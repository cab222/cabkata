class CreateMwodTags < ActiveRecord::Migration
  def change
    create_table :mwod_tags do |t|
      t.integer :mwod_post_id
      t.string :tag

      t.timestamps
    end
  end
end
