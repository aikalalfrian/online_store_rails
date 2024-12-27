# Online Store Project

This project is a proof of concept for an online store application, focusing on inventory management to prevent order cancellations.

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

## Postman Collection

This project includes a Postman collection for testing the API endpoints. You can import the collection into Postman to easily test the API.

### Collection: online_store_api

#### 1. Login
- **Method:** POST
- **URL:** `http://localhost:3000/api/login`
- **Body:** { "email": "default@kiwil.com", "password": "password123" }

#### 2. Register
- **Method:** POST
- **URL:** `http://localhost:3000/api/register`
- **Body:** { "user": { "email": "default_2@kiwil.com", "password": "password123", "password_confirmation": "password123" } }

#### 3. Get Products
- **Method:** GET
- **URL:** `http://localhost:3000/api/products`

#### 4. Get Product by ID
- **Method:** GET
- **URL:** `http://localhost:3000/api/products/{product_id}`

#### 5. Check Inventory for Product
- **Method:** GET
- **URL:** `http://localhost:3000/api/products/{product_id}/check_inventory`

#### 6. Delete Product
- **Method:** DELETE
- **URL:** `http://localhost:3000/api/products/{product_id}`

#### 7. Update Product
- **Method:** PUT
- **URL:** `http://localhost:3000/api/products/{product_id}`
- **Body:** { "stock_quantity": 300 }

#### 8. Checkout User's Cart
- **Method:** GET
- **URL:** `http://localhost:3000/api/users/{user_id}/checkout_history`

#### 9. Get User's Cart
- **Method:** GET
- **URL:** `http://localhost:3000/api/carts`

#### 10. Create Product
- **Method:** POST
- **URL:** `http://localhost:3000/api/products`
- **Body:** { "product": { "name": "Product 1", "stock_quantity": 100 } }

#### 11. Add to Cart
- **Method:** POST
- **URL:** `http://localhost:3000/api/carts`
- **Body:** { "product_id": 4, "quantity": 200 }

#### 12. Checkout Cart
- **Method:** POST
- **URL:** `http://localhost:3000/api/carts/{cart_id}/checkout`





