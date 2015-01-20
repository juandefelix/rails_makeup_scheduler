// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


// refreshing the calendar with AJAX and setInterval()

var adminRefreshInterval;

function getAdminCalendar(){
  $.ajax({
    url: '/admin/cancellations',
    dataType: 'script' 
  })
}  

function updateAdminCalendar(){
  adminRefreshInterval = setInterval(getAdminCalendar, 60000) 
};

$(document).on('page:change', function(){
  var hasAdminCalendar = $('div').is('#admin-calendar-page');
  if(hasAdminCalendar){
    updateAdminCalendar();
  } else {
    clearInterval(adminRefreshInterval);
  }
})

updateAdminCalendar();