class PlacesController < ApplicationController
  
  def index 
    @places = Place.page(params[:page])
  end
end
