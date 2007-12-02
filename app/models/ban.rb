# == Schema Information
# Schema version: 64
#
# Table name: bans
#
#  id         :integer(11)     not null, primary key
#  user_id    :integer(11)     
#  ip         :string(255)     
#  email      :string(255)     
#  message    :string(255)     
#  expires_at :datetime        
#

class Ban < ActiveRecord::Base
  
  def to_s
    id.to_s
  end
  
end
