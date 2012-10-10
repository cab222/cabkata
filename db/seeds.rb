#rake clean=true crawl=true local_create=true

perform_clean = ENV['clean'];
if perform_clean
  puts "Performing clean"
  MwodPost.delete_all
  MwodVideoLink.delete_all
  MwodTag.delete_all
  User.delete_all
end

local_create = ENV['local_create']
if local_create
  date = Date.new;
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
end

crawl = ENV['crawl']
if crawl
  puts "Creating posts by crawling the web..."
  require File.dirname(__FILE__) + '/../app/helpers/mwod_web_crawler'
  crawl_scrape_persist
end  
