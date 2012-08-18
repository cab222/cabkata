# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
MwodPost.delete_all
entry = MwodPost.create(
  :category => :blog,
  :title => "The first mwod post",
  :post_id => 1,
)

entry.mwod_video_link.create(
  :link_id => 1, 
  :mwod_post_id => 1, 
  :link => "http://www.google.com"
)
