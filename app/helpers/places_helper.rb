module PlacesHelper
  def last_comment(place)
    place.comments.order("id ASC").last
  end
end
