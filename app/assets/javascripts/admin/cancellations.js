// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

var getCalendar = function(){
  $.ajax({
      url: 'cancellations',
      dataType: 'script' 
    })
  }  

var updateCalendar = function(){
  setInterval(function(){
    getCalendar();
  }, 10000) 
};

$(document).on('page:change', function(){
  var hasCalendar = $('div').hasClass('ec-calendar');

  if(hasCalendar){
    updateCalendar();
  }
})