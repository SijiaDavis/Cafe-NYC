class PlacesController < ApplicationController
  
  def index 
    @places = Place.page(params[:page])
  end
  
  def new
    @place = Place.new
  end
end
