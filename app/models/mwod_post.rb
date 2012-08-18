class MwodPost < ActiveRecord::Base
  has_many :mwod_video_link
  attr_accessible :category, :date, :title, :post_id 
end
