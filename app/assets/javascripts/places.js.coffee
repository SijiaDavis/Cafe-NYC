# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Check if place is already created by current user
@checkInput = () ->
  element.style.backgroundColor = backgroundColor
  if textColor?
    element.style.color = textColor
    
# Attach event handler to address input field
jQuery ($) ->
  $(document).ready ->
    $("input#place_address").keydown((evt) ->
      # if tab key is pressed
      if evt.which == 9
        $.ajax
          url: "/places/check_unique"
          datatype: "json"
          contenType: "application/json; charset=utf-8"
          type: "GET"
          success: (data) ->             
            alert "Uh Oh" if data.is_uniq_for_user == "false"
          error: (data) -> 
            alert "Something went wrong" 
    )
     
     