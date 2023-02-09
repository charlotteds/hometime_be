# Hometime API

This is an API-only Rails application for Hometime.
Hometime is a leading Australian Prop-tech company solving short-term rental (STR) management at scale.

## Description

This version provides an API endpoint that can accept two payload formats for Reservation creation and update.

## Getting Started

### Prerequisites

Make sure you have the following installed in your computer before running the app.
* Ruby 3.0.1
* MySQL >= 8.0.32
* [Postman](https://www.postman.com/downloads/)

### Local Setup

* Clone the project to your local machine.
```
git clone https://github.com/charlotteds/hometime_be.git
```
* Open the project in your preferred code editor (e.g. VSCode).
* Edit the contents of the `app/config/database.yml` and provide your MySQL `username` and `password`.  
Sample:
```
username: root
password: password
```

### Executing the Program

* Go inside the project directory and run the following commands on your terminal.  
This will install all needed libraries, and set up your local database.
```
bundle install
rails db:create
rails db:migrate
```
* Type the following command to run the application.
```
rails s
```

### How to Test
* Open the Postman application on your computer.
* Enter the following request URL:
```
http://localhost:3000/api/v1/reservations
```
* You may choose between **PATCH** or **POST**, depending on your request.
* Add a **body** to your request, choose **raw**, and **JSON** as type.
* For the body content, you may choose between the two sample payloads below and update the values.  
***Payload #1***
```
{
  "reservation_code": "YYY12345678",
  "start_date": "2021-04-14",
  "end_date": "2021-04-18",
  "nights": 4,
  "guests": 4,
  "adults": 2,
  "children": 2,
  "infants": 0,
  "status": "accepted",
  "guest": {
    "first_name": "Wayne",
    "last_name": "Woodbridge",
    "phone": "639123456789",
    "email": "wayne_woodbridge@bnb.com"
  },
  "currency": "AUD",
  "payout_price": "4200.00",
  "security_price": "500",
  "total_price": "4700.00"
}
```
***Payload #2***
```
{
  "reservation": {
    "code": "XXX12345678",
    "start_date": "2021-03-12",
    "end_date": "2021-03-16",
    "expected_payout_amount": "3800.00",
    "guest_details": {
      "localized_description": "4 guests",
      "number_of_adults": 2,
      "number_of_children": 2,
      "number_of_infants": 0
    },
    "guest_email": "wayne_woodbridge@bnb.com",
    "guest_first_name": "Wayne",
    "guest_last_name": "Woodbridge",
    "guest_phone_numbers": [
      "639123456789",
      "639123456789"
    ],
    "listing_security_price_accurate": "500.00",
    "host_currency": "AUD",
    "nights": 4,
    "number_of_guests": 4,
    "status_type": "accepted",
    "total_paid_amount_accurate": "4300.00"
} }
```
* Click the **Send** button and get the appropriate response to your request.

## Running RSpec Tests

This project makes use of [RSpec](https://rspec.info/). 
Simply type the following command on your terminal to run all the tests.
```
rspec
```

## Authors

Contributors names and contact info

[@charlotte_sacmar](https://www.linkedin.com/in/charlotte-sacmar-233800141/)

## Version History

* 0.1
    * Initial Release
