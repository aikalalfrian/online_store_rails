# Online Store Project

This README documents the necessary steps to set up and run the application.

## Prerequisites
- **Ruby Version**: 3.2.6
- **Rails Version**: 8.0.1
- **System Dependencies**:
  - Ruby 3.2.6
  - Rails 8.0.1
  - Bundler
  - Postgresql

## Configuration
Clone the repository:
git clone https://github.com/aikalalfrian/online_store_rails.git

Install dependencies:
bundle install

Configure the database:
The database configuration file is located at `config/database.yml`. Copy the example configuration file:
cp config/database.yml.example config/database.yml
Edit `config/database.yml` to match your PostgreSQL credentials.

## Database Creation
Create the database by running:
rails db:create

## Database Migration
rails db:migrate

## Database Initialization
You just need to run rails db:migrate, and the first user will be created immediately. After that, you can log in with the following acc:

U: default@kiwil.com
P: password123

## Running the Application
Start the Rails server:
rails server
Access the application at: [http://localhost:3000](http://localhost:3000)

## How to Run the Test Suite
This project uses RSpec for testing. Run all tests with the command:
bundle exec rspec

## Services
This project does not currently use background job processing services like Sidekiq.
