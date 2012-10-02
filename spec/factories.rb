FactoryGirl.define do 
  factory :mwod_post do
    category "blog"
    title "All about ankles 1"
    date "2012-08-19"
    description "ankles are cool"
  end
  
  factory :mwod_tag do
    tag "ankle" 
    mwod_post
  end
  
  factory :mwod_video_link do
    link "http://www.test.com" 
    mwod_post
  end
  
end