module PlacesHelper
  def last_comment(place)
    place.comments.order("id ASC").last
  end
  
  def first_photo(place)
    place.photos.order("id ASC").first
  end
end
