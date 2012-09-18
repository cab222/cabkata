# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
MwodPost.delete_all
MwodVideoLink.delete_all

ankle1 = MwodPost.create(
  :category => :blog,
  :title => "All about ankles 1",
  :date => "2012-08-19",
  :description => "ankles are cool"
)

ankle1.mwod_video_links << MwodVideoLink.create( :link => "http://www.google.com")
ankle1.mwod_video_links << MwodVideoLink.create( :link => "http://www.youtube.com")
ankle1.mwod_tags << MwodTag.create( :tag => "ankle")
ankle1.mwod_tags << MwodTag.create( :tag => "calf")