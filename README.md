# Online Store Project

This README documents the necessary steps to set up and run the application.

## Prerequisites
- **Ruby Version**: 3.0 or higher
- **System Dependencies**:
  - Ruby (3.0 or higher)
  - Bundler
  - PostgreSQL (for development and production environments)

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

## Database Initialization
Load the schema into the database:
rails db:schema:load
If seed data is available, load it using:
rails db:seed

## Running the Application
Start the Rails server:
rails server
Access the application at: [http://localhost:3000](http://localhost:3000)

## How to Run the Test Suite
This project uses RSpec for testing. Run all tests with the command:
bundle exec rspec

## Services
This project does not currently use background job processing services like Sidekiq.
