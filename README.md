# README

This is the repo for the Finance Tracker App built with Ruby on Rails 6

# Build up a Users - users using the app

1. Sign up
  - hashed password
  - Confirmation => Send email to verify
  - forgot password => Send a confirmation link to email just like above

2. Login
  - remember user

3. Logout

# Task: Design and add Stock model
- Attributes name, ticker_symbol and price
- Automate looking up stock (currently only possible through rails console)
- Automate API key insertion (instead of having to key it in everytime we look up a stock)
  - This will expose us to secure credentials in Rails apps:
    credentials.yml.enc (encrypted file)
    master.key (key to decrypt credentials file)

1. Generate a Stock model
rails g model Stock ticker:string name:string last_price:decimal

2. Store secrete key:

Run this command to open credentials file, and add key into it
``
EDITOR="code --wait" rails credentials:edit
``
E.g. we store key like
iex_client:
  publishable_token: "our token"

To reference in code, we use: ``Rails.application.credentials.iex_client[:publishable_token]``