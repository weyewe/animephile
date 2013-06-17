 
class ComicsController < ApplicationController
  def index
    
    
    
    @comics = Comic.page(params[:page]).per( 5 ).order("id DESC")
  end
end
