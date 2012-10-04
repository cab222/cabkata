require 'open-uri'
require 'nokogiri'

def remove_lastchar( input )    
  input[0, input.length-1]
end

def process_blog_entry(blog_entry)
  blog_entry_header = blog_entry.css('[class="post-meta-holder"]')
  blog_title = blog_entry_header.first.content.strip;
  blog_entry_tags = blog_entry.css('[class="post_meta_top"]')
  blog_tag_info =  blog_entry_tags.first.content.strip; 
  blog_tag_info_parts = blog_tag_info.gsub(/\342\200\223/u,"-").split("-");
  blog_tag_info_parts = blog_tag_info.split("\n");

  date = remove_lastchar(blog_tag_info_parts[0].strip).strip
  category = remove_lastchar(blog_tag_info_parts[1].split(":")[1].strip).strip

  tags = remove_lastchar(blog_tag_info_parts[2]).strip.split(":")[1].strip.split(',').collect do |item|
    {:tag => item.strip}
  end

  blog_entry_meat = blog_entry.css('[class="info_holder"]')
  blog_entry_links = blog_entry_meat.css('a')
  blog_entry_links = blog_entry_links.collect do |link_node|
    link_node.attribute("href").content
  end

  youtube_links = blog_entry_links.select do |link|
    link.start_with? "http://www.youtube.com" 
  end
  youtube_links = youtube_links.collect do |link|
    { :link => link}
  end
  
  description_node = blog_entry_meat.xpath '//p/text()';
  
  processed_post_hash = Hash.new;
  processed_post_hash[:title] = blog_title
  processed_post_hash[:category] = category
  processed_post_hash[:mwod_video_links_attributes] = youtube_links
  processed_post_hash[:mwod_tags_attributes] = tags
  processed_post_hash[:date] = date
  processed_post_hash[:description] = "a blank description"
  processed_post_hash
end

def crawl_scrape_persist
  url = "http://www.mobilitywod.com";
  doc = Nokogiri::HTML(open(url))
  unless doc.nil?
    posts = doc.css('[class="post_entry blog"]');
    posts.each do |blog_entry|
      processed_post_hash = process_blog_entry blog_entry
      mwod_post = MwodPost.new processed_post_hash
      p mwod_post
      mwod_post.save if mwod_post.valid?
    end
  end  
end

crawl_scrape_persist
