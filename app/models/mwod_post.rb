class MwodPost < ActiveRecord::Base
  validates :title, :category, :description, :presence => true
  validates :title, :uniqueness => true
  has_many :mwod_video_links
  has_many :mwod_tags
  accepts_nested_attributes_for :mwod_video_links, :reject_if => lambda{ |a| a[:link].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :mwod_tags, :allow_destroy => true
  attr_accessible :category, :date, :title, :mwod_video_links_attributes, :description, :mwod_tags_attributes
  before_destroy :ensure_not_referenced_by_mwod_post
  
  
  #TEST THIS
  #ADD CHECK FOR TAGS
  private
  def ensure_not_referenced_by_mwod_post
    if mwod_video_links.empty? 
      return true
    else
      errors.add(:base, 'has mwod video links, delete first')
      return false
    end
  end
  
  def to_s
    "Post: #{title}--#{category}  #{mwod_video_link.join(',')}"
  end
end
