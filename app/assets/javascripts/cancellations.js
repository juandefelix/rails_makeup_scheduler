// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.


// # close_window = (url) ->
// #   newWindow = window.open '', '_self', ''
// #   window.close(url);

// # validateDateTime = ->
//   # the dateTime when the user submit the form
//   # notificationDateTime = new Date
//   # notificationDateTime.setDate(notificationDateTime.getDate() + 1) # +1 day

//   # the date of the absence (entered by the user)
//   # date = $("#date").val()
//   # dateParts = date.split("/")

//   # the hour of the absence (entered by the user)
//   # time = $("select").val()
//   # timeParts = time.match(/(\d{2}):(\d{2})/)

//   # dateTime of the absence
//   # absenceDateTime = new Date("20" + dateParts[2], (dateParts[0] - 1), dateParts[1], timeParts[1], timeParts[2])

//   # notificationDateTime > absenceDateTime

// # $("#exit").click (event) ->
// #   event.preventDefault()
// #   close_window()

// #$(document).ready ->   # $(document).on "page:change", -> # this will load the javascript when every page is 'loaded' when using turbolinks
//   # comparing the dates
//     # $("#new_cancellation").submit (event) ->
//     #   event.preventDefault()
//     #   if validateDateTime()
//     #     alert "Your absence should be notified at least 24hr. before your class"
//     #   else
//     #     $.ajax
//     #       url: "/cancellations"
//     #       type: 'POST'
//     #       data: $("form").serialize() 
//     #       dataType: 'json'
//     #       error: -> 
//     #         console.log "error" 
//     #         # $(".alert alert-error")."Your submission has errors"
//     #         # alert "Please, fill in all the fields in the form" 
//     #       success: (r) -> window.location = "/cancellations/" + r
// var hasCalendar = $( "div" ).hasClass("ec-calendar")





// refreshing the calendar with AJAX and setInterval()

var pageRefresher = function($, css, url){
  var self = {};
  var myTimeInterval;

  self.getContent = function(){
    $.ajax({
      url: url,
      dataType: 'script' 
    }).done(function(){
      console.log(css + ' success');
    }).fail(function() {
    console.log( "error" );
    })
  }; 

  self.updateHtml = function(){
    myTimeInterval = setInterval(self.getContent, 60000) 
  };

  self.toggleAjax = function(){

    var hasElement = $('div').is(css)

    if(hasElement){
      self.updateHtml();
    } else {
      clearInterval(myTimeInterval);
    } 
  };

  return {
    refreshPage:function(css, url){
      $(document).on('page:change', self.toggleAjax);
    }
  };

}; // end object

var calendarRefresher = pageRefresher($, "#calendar-page", "/cancellations")
calendarRefresher.refreshPage()

var adminCalendarRefresher = pageRefresher($, "#admin-calendar-page", "/admin/cancellations")
adminCalendarRefresher.refreshPage()

$(document).on('page:change', function(){
  $(function() {
    $(".form-date").datepicker({ dateFormat: "mm/dd/y", minDate: 1 })
  });
})