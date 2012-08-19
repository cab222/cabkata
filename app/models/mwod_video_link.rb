class MwodVideoLink < ActiveRecord::Base
  belongs_to :mwod_post
  attr_accessible :link, :mwod_post_id
end
