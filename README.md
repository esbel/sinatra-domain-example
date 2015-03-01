Sample application to demonstrate how to structure domain model, interactions (service objects) and business rules. All this is wrapped into a SinatraRB microservice. Tests are proudly provided by RSpec3.

User story
==========

*Display customer's available rewards*
As a customer, if I am eligible for rewards, then I want to see which rewards
are available based on my channel subscriptions.

Requests and responses
======================

    http://localhost:9292/rewards?account_number=CATCH22&channel_subscriptions[]=KIDS
    #=> {"rewards":[],"error":false}


    http://localhost:9292/rewards?account_number=CATCH22&channel_subscriptions[]=SPORTS
    #=> {"rewards":["CHAMPIONS_LEAGUE_FINAL_TICKET"],"error":false}


Installation & Running
======================

    $ bundle install


    $ puma
