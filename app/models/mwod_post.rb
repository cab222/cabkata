class MwodPost < ActiveRecord::Base
  validates :title, :category,  :presence => true
  validates :title, :uniqueness => true
  has_many :mwod_video_link
  attr_accessible :category, :date, :title 
end
