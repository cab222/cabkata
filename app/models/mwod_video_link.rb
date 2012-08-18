class MwodVideoLink < ActiveRecord::Base
  belongs_to :mwod_post
  attr_accessible :link_id, :mwod_post_id, :link
end
