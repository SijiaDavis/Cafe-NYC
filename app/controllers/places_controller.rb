class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :check_unique]
  
  def index 
    @places = Place.order(:id).page(params[:page])
  end
  
  def new
    @place = Place.new
  end
  
  def create 
    puts "hello I am #{current_user} in create"
    @place = current_user.places.create(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new
  end
  
  def edit
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end
  end
  
  def update
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end
    
    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to place_path(@place)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end
    
    @place.destroy
    redirect_to root_path
  end
  
  def check_unique
    puts "hello I am #{current_user}"
    head current_user.places.where(place_params).present? ? :conflict : :ok
  end
  
  private
  
  def place_params
    params.require(:place).permit(:name, :description, :address)
  end  
end
