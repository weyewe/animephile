class Page < ActiveRecord::Base
  attr_accessible :comic_id, :page_number, :image_url, :local_url
  belongs_to :comic

  def save_file

  	comic_id = comic.id.to_s
  	current_id = self.id.to_s
  	puts "/result/#{comic_id}/#{current_id}"  


  	master_location = "#{Rails.root.to_s}/public/result/"

  	directory_name = master_location + comic.id.to_s + "/"

  	file_name = directory_name + self.id.to_s


	 Dir.mkdir(directory_name) unless File.exists?(directory_name)


	  the_url =  self.image_url # "http://www.animephile.com/mangagallery/Chounyuu For You/Volume 01/chounyuu_v01_168.JPG"
	  awesome_url = the_url.gsub(" " , "%20") 

	  system( "wget -O #{file_name}  #{awesome_url}"  )


	  # File.open( file_name , "wb") do |saved_file|
	  # # the following "open" is provided by open-uri

	  # the_url =  self.image_url # "http://www.animephile.com/mangagallery/Chounyuu For You/Volume 01/chounyuu_v01_168.JPG"
	  # awesome_url = the_url.gsub(" " , "%20") 


	  #   open( awesome_url , "rb") do |read_file|
	  #    saved_file.write(read_file.read)
	  #   end
	  # end

	  self.local_url = "/result/#{comic_id}/#{current_id}"  
	  self.save


  end
  
   
end
