class MwodTag < ActiveRecord::Base
  belongs_to :mwod_post
  attr_accessible :mwod_post_id, :tag
  validates_presence_of :mwod_post_id, :tag
end
