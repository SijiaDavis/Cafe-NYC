class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index 
    @places = Place.order(:id).page(params[:page])
  end
  
  def new
    @place = Place.new
  end
  
  def create 
    @place = current_user.places.create(place_params)
    if @place.valid?
      return render_duplicate if Place.where(place_params).present?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @place = Place.find_by_id(params[:id])
    return render_not_found if @place.blank?
    @comment = Comment.new
    @photo = Photo.new
  end
  
  def edit
    @place = Place.find_by_id(params[:id])
    return render_not_found if @place.blank?  
    return render_not_allowed if @place.user != current_user
  end
  
  def update
    @place = Place.find_by_id(params[:id])
    return render_not_found if @place.blank? 
    return render_not_allowed if @place.user != current_user

    @place.update_attributes(place_params)
    if @place.valid?
      return render_duplicate if Place.where(place_params).present?
      redirect_to place_path(@place)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @place = Place.find_by_id(params[:id])
    return render_not_found if @place.blank? 
    return render_not_allowed if @place.user != current_user
    @place.destroy
    redirect_to root_path
  end
  
  def check_unique
    head current_user.places.where(place_params).present? ? :conflict : :ok
  end
  
  private
  
  def place_params
    params.require(:place).permit(:name, :description, :address)
  end  
  
  def render_not_found
    render text: 'Sorry, the cafe you are looking for is not found...', status: :not_found
  end
  
  def render_not_allowed
    render text: 'Not Allowed', status: :forbidden
  end
  
  def render_duplicate
    render :edit, status: :conflict
  end
end
