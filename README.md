# README

# Startupz coding challenge
## Dependencies
* Ruby version : 2.7.2
* Rails Version : 6.1.4

## Setup with Docker

### Prerequisites

* Docker
### Setup

```
$ docker-compose up
$ docker-compose run web rake db:create db:migrate db:seed
$ docker-compose run web rspec
```
## Local Setup

## Configurations
```gem install bundler && bundle install```

## Setup and Start the Applicaton
### Database Setup
```rake db:create db:migrate && rake db:seed```
### Run the rails server
```rails s```
## Test Environment Setup
### Test Database Setup
```RAILS_ENV=test rake db:create && RAILS_ENV=test rake db:migrate```
### Run the Test Suit
```rspec```

## Assumptions
* source language code and target language code should be required while creating glossary.
* Only language codes allowed that are contained in the csv.

## Postman Collection
* file translator_api.postman_collection.json

## Future Enhancements
* Using internationalisation gem I18n for translating application to a single custom language.
* Using swagger for API documentation.
* Use Faker for creating fake random test data.
* Can use serializers for custom API responses.