require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'cgi'


class Comic < ActiveRecord::Base
  attr_accessible :title, :url, :total_page 
  has_many :pages 
  
  # Comic.create_and_parse_images('birthday',  'http://www.animephile.com/hentai/birthday.html?ch=Volume+01',  210)
  # Comic.extract_images('My Mother',  'http://www.animephile.com/hentai/my-mother.html?ch=Volume+01',  3)
  def self.extract_images(title, url, total_page)
    images = [] 
    
    begin
      (1..total_page).each do |page_number|
        # http://www.animephile.com/hentai/my-mother.html?ch=Volume+01      &page=191
        page_url = url + "&page=#{page_number}"
        page = Nokogiri::HTML(open(  page_url     ))  
        
        result = page.css("#mainimage")
        images <<  result.map {|x| x['src'] } .first
         
      end
      
      return images
      
    rescue 
      return nil 
    end
    
    
  end
  
  def self.create_and_parse_images(title, url, total_page )
    images = self.extract_images(title, url, total_page )
    
    if not images.nil? and images.length != 0 
      comic = self.create :title => title, :url => url, :total_page => total_page 
      comic.create_pages( images )
    end 


    comic.pages.each {|x| x.save_file }
  end
  
  def create_pages( images ) 
    page_number = 1 
    images.each do |  image_url |
      regex = /(http:.+\.jpg)/i
      regex.match image_url
      cleaned_image_url = $1
      
      result_page = Page.create :comic_id => self.id, :page_number => page_number, 
              :image_url => cleaned_image_url

      # result_page.save_file
              
      page_number += 1
    end
  end
end


=begin
  
  directory_name = "#{Rails.root.to_s}/public/result/1"
  Dir.mkdir(directory_name) unless File.exists?(directory_name)


  File.open( directory_name , "wb") do |saved_file|
  # the following "open" is provided by open-uri

  the_url = "http://www.animephile.com/mangagallery/Chounyuu For You/Volume 01/chounyuu_v01_168.JPG"
  awesome_url = the_url.gsub(" " , "%20") 


    open( awesome_url , "rb") do |read_file|
     saved_file.write(read_file.read)
    end
  end
=end
