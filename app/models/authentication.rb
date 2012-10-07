class Authentication < ActiveRecord::Base
  belongs_to :user 
  attr_accessible :user_id, :provider, :uid
  
  def to_s
    "#{user_id} #{provider} #{uid}"
  end
end
