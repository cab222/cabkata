class MwodPost < ActiveRecord::Base
  validates :title, :category, :description, :presence => true
  validates :title, :uniqueness => true
  has_many :mwod_video_links, :inverse_of => :mwod_post
  has_many :mwod_tags, :inverse_of => :mwod_post
  accepts_nested_attributes_for :mwod_video_links, :allow_destroy => true, :reject_if => lambda{|a| a[:link].blank? }
  accepts_nested_attributes_for :mwod_tags, :allow_destroy => true, :reject_if => lambda{|a| a[:tag].blank? }
  attr_accessible :category, :date, :title, :mwod_video_links_attributes, :description, :mwod_tags_attributes
  before_destroy :ensure_not_referenced_by_mwod_post
  validates :mwod_video_links, :presence => true
  validates :mwod_tags, :presence => true
  validate :validate_has_many_relationship

  private
  def validate_has_many_relationship
    
    errors.add(:mwod_tags, "is empty") if mwod_tags.length == 0
    errors.add(:mwod_video_links, "is empty") if mwod_video_links.length == 0
  end
  
  private
  def ensure_not_referenced_by_mwod_post
    if mwod_video_links.empty? && mwod_tags.empty?
      return true
    else
      errors.add(:base, 'has video links or tags, delete first')
      return false
    end
  end
  
  def to_s
    "Post: #{title}--#{category}  "
  end
end
