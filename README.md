# README

* Ruby version is 3.2.2 with rails 7.0

* Database: this app does not rely on any database yet, for all purposes it uses an embedded sqlite as a starting point

* To run the test suite: `rspec`

* To run locally
  * Be sure to have ruby and bundler installed (use `gem install bundler` if you need to)
  * Install all dependencies using `bundle install`
  * Spin a server using `bundle exec rails s` and access the application on localhost:3000

* TODO List
  * Add bootstrap for better visuals
  * Add a spec to the controller, I only tested the service for its priority within the given time
  * Add rubocop to ensure code quality according to standards
  * Add better state messages (blank state for the initial form, empty state for tags without any instance of items after a search)
  * Add support for choosing which tags the customer wants to list, interface is still locked on `img` and `a`, but the service already supports any given tag and its main attribute to read from