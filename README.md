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
This app is called Visit Check because that is the essence of the Code Challenge, it checks if the user had visited certain sites and if he/she did it will print out the sites in order of most recently visited.

This is not all working as I did not implement the cache timing script from Michal Zalewski's site but I tried to do as much as I can setting up the Rails project for it. Unfortunately my Javascript abilities require more practice. I think I'm close, if I spend another day or two I can probably get it all working.

###Requirements Walkthrough
This application has 3 main areas to directly address the requirements in Code Challenge document.

####1. Simple User Signup
Instead of Devise I ended up just writing a really simple one that took very little time. Devise's documentation said that one should write their own before using Devise to have a better appreciation for it. My implementation required Bcrypt and having the attribute `password_digest` and therefore no more stuff like:

```sh
self.password_salt = BCrypt::Engine.generate_salt
self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
```

####2. App model and apps controller
This App model and controller helps store the application name and resource url into the database. I chose to store the resource url as text in case that a resource url exceeds the 255 character limit of a string.

I set the controller so that routes are only accessible when the user is logged in. The controller's methods are organized in CRUD order, no real reason other than I found that it was easier for me to see if I have all the methods I would need.

One can create, edit or destroy apps using the views I created or just simply go by apps that were put in via a seed file.

Users will all access the same `apps` table. I figure that this table should be a general list for all and the user's own cache will tell us which within the table he/she visited.

####3. Visit model and apps controller
This is the 'apps_users' table described in the requirements. I changed the name so that it's shorter and that it better matches the app name I gave the project.

There is an association between the Visit model and User model. User has many Visits and Visit belongs to User. This is so that results for each user will be isolated and recorded individually.

There are only 3 actions: create, index, and destroy. I figure there's no need for anyone to edit the data manually. Destroy is there so that if the user sees the list and doesn't want something on the list, he/she can choose to destroy it. 

The create action however is both create and update. I wanted to create a table such that when a user decides to figure out what sites were visited, he/she may do that multiple times and if so we don't always need to create a new entry. So the create action first sees if it can find parameter and if it can't it will create it. Otherwise it will update what's already in the table. I used `count` as a way to see if first_or_create method created or not.

Another way to look at this is, if the `apps` table is not updated, the create action for the visits controller should be updating existing entries each time cache timing is run. If the `app` table is updated with new entries then the create action would be creating new entries for the user if the user visits those apps.

###Work still to be done
I need to take Michal Zalewski's Chrome code here http://lcamtuf.coredump.cx/cachetime/chrome.html and make changes. So instead of the URLs he has I'll need to interface my `apps` table into his javascript. Also, once cache timing is performed instead of outputing it direct I need to interface with the `visits` table and write into it, and then display from the table. Still plenty more work to be done but I feel that the rails app is basically ready for it all. 

###Order of Operation if it were all working
Just like the flow of the Code Challenge document:

1. User logs into the application
2. JS pulls from the `apps` table the name and resource url and starts checking how much time it takes to load the resource url asset.
3. AJAX call sends the name and time to be recorded in the `visits` table, either update existing or create new.
4. Screen updates basically printing everything from the `visits` table in order from shortest time to longest.

###Thoughts on keeping resource url's up to date
If we want to keep it really really simple, one way to do this is to only use favicons for cache timing. So we can build a crawler that determines if the favicon for each app had changed url or not and upddate accordingly.

But it seems that the in the cache timing code Michal Zalewski was looking at specifically static assets around 10kB so we can build a crawler that way too that goes to each site, looks at the source and finds a static resource that's roughly 10kB +/- 10% and updates the resource url that way. This is more involved but results may be better as Michal did say "they are a very stable and predictable target."

###Other thoughts
Cache timing is pretty interesting and it got me thinking more about how it can help find usage patterns. So first off perhaps with the `apps` table we should include the app category too. Mail category for say Gmail, Outlook, etc. Productivity category for Google Docs, Office 365, Evernote, etc. So with these categories, coupled with the most recently used apps data from cache timing, we can pair these up with a recommendation engine to find apps that a user is not using that he/she may want to use.

So User 1 may use Outlook, Office 365, Bitbucket in his workflow while most users use Gmail, Google Docs, Github and give a recommendation that perhaps User 1 may want to switch to more popular apps in those mail, productivity, and code repository categories.

And I think knowing what apps users use more can help prioritize which apps get higher priority to get working when building out this app further.

###And Finally
I included a few badges at the top of this Readme just so that you can quickly see where this app stands in terms of code quality, test coverage, and such. And because of the badges this is why this project is on my Github instead of being zipped up and emailed to you.

I purposely tried to keep things simple. Gitflow workflow to try to make the commits tell a story. I followed the Github Ruby style guide as much as possible. And finally I kept the testing as simple as possible, no Capybara mainly so that I can understand routing better.

I had a lot of fun building this project. Thank you for your time.
