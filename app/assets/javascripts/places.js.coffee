# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
    
# Attach event handler to address input field
jQuery ($) ->
  $(document).ready ->
    $("input#place_address").keydown((evt) ->    
      # if tab key is pressed
      if evt.which == 9
        # get form inputs
        placeName = $("#new_place #place_name").val()
        placeDesc = $("#new_place #place_description").val()
        placeAddr = $("#new_place #place_address").val()
        
        inputs = {
          place: {
            name: placeName,
            description: placeDesc,
            address: placeAddr
          }
        }
          
        $.ajax
          url: "/places/check_unique"
          datatype: "json"
          contenType: "application/json; charset=utf-8"
          data: inputs
          type: "POST"         
          error: (data) -> 
            $(".container").prepend('<div class="alert alert-danger">You already wrote about this place.</div>') if data.status == 409
    )
     
     