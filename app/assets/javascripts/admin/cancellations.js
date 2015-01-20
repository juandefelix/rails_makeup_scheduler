// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

var getAdminCalendar = function(){
  $.ajax({
      url: '/admin/cancellations',
      dataType: 'script' 
    })
  }  

var updateAdminCalendar = function(){
  setInterval(function(){
    console.log("Time!");
    getAdminCalendar();
  }, 60000) 
};

$(document).on('page:change', function(){
  var hasAdminCalendar = $('h1').is('#admin-calendar-page');
  console.log(hasAdminCalendar)
  if(hasAdminCalendar){
    updateAdminCalendar();
  }
})