class Page < ActiveRecord::Base
  attr_accessible :comic_id, :page_number, :image_url
  belongs_to :comic
  
   
end
