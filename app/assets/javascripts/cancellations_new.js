var validateDateTime = function(){

      // the dateTime when the user submit the form
      var notificationDateTime = new Date();     
      notificationDateTime.setDate(notificationDateTime.getDate() + 1); // +1 day

      // the date of the absence (entered by the user)
      var date = $("#cancellation_date").val();
      var dateParts= date.split("/");

      // the hour of the absence (entered by the user)
      var time = $("select").val(); 
      var timeParts = time.match(/(\d{2}):(\d{2})/);

      // dateTime of the absence
      var absenceDateTime = new Date("20" + dateParts[2], (dateParts[0] - 1), dateParts[1], timeParts[1], timeParts[2]);

      return notificationDateTime > absenceDateTime
  }

  $(document).ready(function(){
    $("#new_cancellation").submit(function(event){
      event.preventDefault();


      // comparing the dates
      if (validateDateTime()) {
        alert("Your absence should be notified at least 24hr. before your class");
      }
      else{
        $.ajax({
          url: "/cancellations",
          type: 'POST',
          data: $("form").serialize() ,
          dataType: 'json',
          error: function(){ 
            console.log("error") 
          },
          success: function(r){ 
            window.location = "/cancellations/" + r;
          }
        }) // end ajax
      } // end else
    }); // end submit
  }); // end document