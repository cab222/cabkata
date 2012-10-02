class MwodVideoLink < ActiveRecord::Base
  belongs_to :mwod_post
  attr_accessible :link, :mwod_post_id
  validates_presence_of :mwod_post  
  def to_s
    "Link: #{link}"
  end
end
