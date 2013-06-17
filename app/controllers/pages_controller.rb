class PagesController < ApplicationController
  def index
    @comic = Comic.find_by_id params[:comic_id]
    @pages = @comic.pages.order("page_number ASC")
  end
end
