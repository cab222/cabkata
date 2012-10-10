require 'open-uri'
require 'nokogiri'

def remove_lastchar( input )    
  input[0, input.length-1]
end

def logger
  if @logger == nil
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
  end
  @logger
end

def process_blog_entry(blog_entry)
  blog_entry_header = blog_entry.css('[class="post-meta-holder"]')
  blog_entry_header_first = blog_entry_header.first
  blog_entry_header_first_content = blog_entry_header_first.content
  blog_title = blog_entry_header_first_content.strip;
  logger.debug {"Blog title: #{blog_title}"}
  
  blog_entry_tags = blog_entry.css('[class="post_meta_top"]')
  blog_entry_tags_first =  blog_entry_tags.first
  blog_entry_tags_first_content = blog_entry_tags_first.content
  blog_tag_info = blog_entry_tags_first_content.strip;   
  blog_tag_info_parts = blog_tag_info.gsub(/\342\200\223/u,"-").split("-");
  blog_tag_info_parts = blog_tag_info.split("\n");
  
  logger.debug {"Blog Tag Info Parts: #{blog_tag_info_parts.size}"}

  if blog_tag_info_parts.size == 4
    date = remove_lastchar(blog_tag_info_parts[0].strip).strip
    category = remove_lastchar(blog_tag_info_parts[1].split(":")[1].strip).strip

    tags = remove_lastchar(blog_tag_info_parts[2]).strip.split(":")[1].strip.split(',').collect do |item|
      {:tag => item.strip}
    end
  else
    date = nil
    category = "Blog"
    tags = []  
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

def scrape_page(url)
  doc = Nokogiri::HTML(open(url))
  unless doc.nil?
    posts = doc.css('[class="post_entry blog"]');
    posts.each do |blog_entry|
      processed_post_hash = process_blog_entry blog_entry
      mwod_post = MwodPost.new processed_post_hash
      logger.debug mwod_post
      mwod_post.save if mwod_post.valid?
    end
    
    links = doc.xpath('//a[@href]').collect do |link|
      link["href"]
    end  
    links = links.grep(/http:\/\/www.mobilitywod.com\/page*/)
  end  
  links  
end

def crawl_scrape_persist
  links_processed = Hash.new
  links_added = Hash.new
  queue = Queue.new
  queue << "http://www.mobilitywod.com"
  
  while !queue.empty?
    url = queue.pop
    logger.debug "processing: " + url
    new_links = scrape_page(url)
    links_processed[url] = true
    new_links.each do |link|
      if !links_added.has_key? link
        logger.debug "adding link: " + link
        links_added[ link ] = true
        queue << link 
      end  
    end
    logger.info "queue size is: " + queue.size.to_s
  end
end
