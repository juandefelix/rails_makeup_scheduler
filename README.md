## MAKEUP SCHEDULER  ##

This is an application built in Rails 4.0

In order to run this application you should have intalled Rails 4.0.
Copy this repo in your computer. In you terminal got to the application folder and type:  
`bundle install`  
To start the rails server, run in your console:  
`rails s`  
You shold be able to see the home page in your browser typing `localhost:3000/` in your browser.

###About This Application###
This application was built to help some small business like music schools, to help manage student absences. Currently these absences are notified by phone or email, which takes so much time. With this application, the student notify their absences filling a form in this web application. The administrator will be able to see and manage all the notified absences in one single page instead of several emailes.


####Where I Am  
Wrote association between Users and Cancellations. A user can create and 'take' many cancellations. A cancellation wil have a creator and a 'taker'. Wrote tests for a user creating cancellations. There are **missing tests for a User taking cancellations (makeups)**.  
A user can only create absences if it is signed in. The cancellations will have the same `creator` as the `user.id`  
A user with admin privileges is allowed to delete cancellations.  
A user can't take cancellations if they are reserved or if the are in a past date.
**Need to:**  
 - Write acceptance tests for a user taking a cancellation. 
 - `check_date_format` should verify both the date and the time are valid and load a different flash message when any of these are not valid.
