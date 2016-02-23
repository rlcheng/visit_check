##Visit Check app README

[![Code Climate](https://codeclimate.com/github/rlcheng/visit_check/badges/gpa.svg)](https://codeclimate.com/github/rlcheng/visit_check)
[![Dependency Status](https://gemnasium.com/rlcheng/visit_check.svg)](https://gemnasium.com/rlcheng/visit_check)
[![Coverage Status](https://coveralls.io/repos/github/rlcheng/visit_check/badge.svg?branch=master)](https://coveralls.io/github/rlcheng/visit_check?branch=master)
[![Build Status](https://travis-ci.org/rlcheng/visit_check.svg?branch=master)](https://travis-ci.org/rlcheng/visit_check)

###To install
Make sure you have the correct Ruby version. Check .ruby-version at root of the project or in the gemfile.

```sh
bundle install
rake db:create
rake db:migrate
rails s
```

###Introduction
This app is called Visit Check because that is the essence of the project, it checks if the user had visited certain sites and if he/she did it will print out the sites in order of most recently visited.

This is not all working as I did not implement the cache timing script from Michal Zalewski's site but I tried to do as much as I can setting up the Rails project for it.

###Requirements Walkthrough
This application has 3 main areas to directly address the requirements in Code Challenge document.

####Simple User Signup
Instead of Devise I ended up just writing a really simple one that took little time. Devise's documentation said that one should write their own before using Devise to have a better appreciation for it. My implementation required Bcrypt and having the attricute ``password_digest`` and therefore no more stuff like:

```sh
self.password_salt = BCrypt::Engine.generate_salt
self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
```

####App model and apps controller
This App model and controller helps store the application name and resource url into the database. I chose to store the resource url as text in case that a resource url exceeds the 255 character limit of a string.

I set the controller so that routes are only accessible when the user is logged in. The controller's methods are organized in CRUD order, no real reason other than I found that it was easier for me to track if have all the methods I would need.

One can create, edit or destroy apps using the views I created or just simply go by apps that were put in via a seed file.

####Visit model and apps controller
This is the 'apps_users' table described in the requirements. I changed the name so that it's shorter and that it better matches the app name I gave the project.

!!!!!!need to make some updates to the Visit model will revisit readme after!!!!!!!!!!!!!!

###Order of Operation
Just like the flow of the Code Challenge document:

1. User logs into the application
2. JS pulls from the `apps` table the name and resource url and starts checking how much time it takes to load the resource url asset.
3. AJAX call sends the name and time to be recorded in the `visits` table, either update existing or create new.
4. Screen updates basically printing everything from the `visits` table in order from shortest time to longest.

###Thoughts on keeping resource url's up to date
!!!!!!!!!!write stuff here!!!!!!!!!

###Other thoughts
!!!!!!!!!!write stuff here!!!!!!!!!

###And Finally
I included a few badges at the top of this Readme just so that you don't have to dive into the code or this readme to see where this app stands in terms of code quality, test coverage, and such.

I had a lot of fun building this project. Thank you for your time.