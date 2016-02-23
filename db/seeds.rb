# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#App
App.create!(name: "Gmail",
  resource_url: "https://ssl.gstatic.com/ui/v1/icons/mail/images/favicon5.ico")
App.create!(name: "Youtube",
  resource_url: "https://s.ytimg.com/yts/cssbin/www-core-webp-vfl9mkP-h.css")
App.create!(name: "Facebook",
  resource_url: "https://static.xx.fbcdn.net/rsrc.php/v2/yp/r/I5kTXq1bSJZ.css")
App.create!(name: "Github",
  resource_url: "https://assets-cdn.github.com/assets/github-905189691a6028f88cd80210851a8dde5035886fe94a7dcd64c853a342d165fc.js")
App.create!(name: "Amazon", 
  resource_url: "https://images-na.ssl-images-amazon.com/images/G/01/AUIClients/AmazonUI-a0d292b78b05834723a8a6677d07835232a37a69._V2_.css")

#User
user = User.create!(email: "user@user.com", password: "password")

#Visit
user.visits.create!(name: "Gmail", time: 0.5)
user.visits.create!(name: "Youtube", time: 0.1)
user.visits.create!(name: "Facebook", time: 2.5)
user.visits.create!(name: "Github", time: 1.5)
user.visits.create!(name: "Amazon", time: 0.3)
