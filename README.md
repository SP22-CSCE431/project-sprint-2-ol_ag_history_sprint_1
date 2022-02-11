# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

  In order to run you must run these commands everytime you update
  
  -bundle install
  -rails webpacker:install (might be optional)
  -rails db:create
  -rails db:migrate
  
  alternatively run this command: bundle install && webpacker:install && rails db:create && rails db:migrate

* Database creation

  rails g scaffold [tablename] [varname:type] 
  rails generate scaffold [tablename] [varname:type] 
  
* Database update

  rails g migration [Migration name] (depeneding on what you want you need to name this specifically) 

  alternativly name the migration somthing generic and modify the file manualy then db:migrate
  
* Database initialization

  rails db:migrate (Need to be done after every migration and sacffold)

* How to run the test suite

  rails spec*

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

  Test and Main will auto deploy to heroku
  
  Local deployment
    -rails s
    -rails s --binding=0.0.0.0 (if the former doesn't work)
    
