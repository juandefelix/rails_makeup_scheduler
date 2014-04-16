# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



# function close_window(url){
#  var newWindow = window.open('', '_self', ''); //open the current window
#    window.close(url);
# }


close_window = (url) ->
  newWindow = window.open '', '_self', ''
  window.close(url);

$ ->
  $("#exit").click (event) ->
    event.preventDefault()
    close_window()
