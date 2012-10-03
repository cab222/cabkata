FactoryGirl.define do 
  factory :mwod_post, :class => :MwodPost do
    category "blog"
    title "All about ankles 1"
    date "2012-08-19"
    description "ankles are cool"

    before(:create) do |mwod_post|
      mwod_post.mwod_tags << FactoryGirl.build(:ankle_tag, tag: "ankle", mwod_post: mwod_post)
      mwod_post.mwod_video_links << FactoryGirl.build(:youtube_link, link: "http://www.test.com", mwod_post: mwod_post)
    end
  end
  
  factory :ankle_tag, :class => :MwodTag do
     tag {}
     mwod_post {}
  end
  
  factory :youtube_link, :class => :MwodVideoLink do 
     link {}
     mwod_post {}
  end
end