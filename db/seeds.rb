#rake clean=true crawl=true local_create=true update_admin=true
logger = Logger.new(STDOUT)
logger.level = Logger::INFO

perform_clean = ENV['clean'];
if perform_clean
  logger.info "Performing clean"
  MwodPost.delete_all
  MwodVideoLink.delete_all
  MwodTag.delete_all
  User.delete_all
  Authentication.delete_all
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
  logger.info "Creating posts by crawling the web..."
  require File.dirname(__FILE__) + '/../app/helpers/mwod_web_crawler'
  crawl_scrape_persist
end  

admin = ENV['update_admin']
if admin
  user = User.where("email = 'carlo.barbara@gmail.com'").first
  logger.info "#{user.email}"
  user.administrator = true
  user.save!  
end