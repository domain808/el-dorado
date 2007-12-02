# == Schema Information
# Schema version: 64
#
# Table name: settings
#
#  id           :integer(11)     not null, primary key
#  title        :string(255)     
#  tagline      :string(255)     
#  announcement :text            
#  footer       :text            
#  theme_id     :integer(11)     
#  favicon      :string(255)     
#

class Setting < ActiveRecord::Base
  
  def to_s
    title.to_s
  end
  
end
