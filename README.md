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
Users signup, signin and logout is already implemented and tested.  
Wrote association between Users and Cancellations. A user can create and 'take' many cancellations. A cancellation wil have a creator and a 'taker'. Wrote tests for a user creating cancellations. There are **missing tests for a User taking cancellations (makeups)**.  
A user can only create absences if it is signed out. The cancellations will have the same `creator` as the `user.id`
Added `rolify` gem. A user can have a role.
**Need to:**  
 - Need to rewrite the tests for the new signed_in? method.
 - Write tests for a user taking a cancellation.
 - Add `cancan` gem to allow user with different roles to do different actions
