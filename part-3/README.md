# Part 3: Build a CRUD App

## Summary
In Part 3 of the assessment, we'll demonstrate our proficiency in building Sinatra applications: user authentication, associations, validations, controllers, views, etc. Even a little bit of CSS.

### Site Overview
We'll be building a simplified version of a blind auction site—in a blind auction, bidders do not see how much other bidders have bid.

The required functionality of the site will be described in more detail in the *Releases* section, but here's a basic overview.

**Unregistered Users**
- Register a new account.
- Browse available items.

**Registered Users**
- Sign in and out
- List items.
- Browse available items.
- Bid on available items that other users have listed.
- Have a profile showing their listing and bidding activity.

### Provided Code
For this part of the assessment, you are provided with a Sinatra skeleton.  All but one of the migrations have been provided for you.  Some empty models have also been provided, but you will need to create another.

### Completing the App and Estimated Times per Release
Complete as much of this CRUD app as possible in the time allowed.  If time is running out and it looks like the app will not be completed, continue to work through the releases in order and complete as much as possible.   Each of the release sections has an estimated time.  This is the approximate length of time it should take to complete the release.  Be sure to ask questions, if it's taking a lot longer to complete a release.

## Releases
### Pre-release:  Setup (< 5 minutes)
We'll need to make sure that everything is set up before we begin working on the application.  From the command line, navigate to the `part-3` directory of the phase 2 assessment.  Once there, run ...

1. `$ bundle`
1. `$ bundle exec rake db:create`

### Release 0: Add Model and Migration (10 - 15 minutes)
Create both an empty `User` model and a migration to create the corresponding `users` table.  The table will need to store a username and an encrypted version of the password.  Once that is complete, run the following commands:

1. `$ bundle exec rake db:migrate`
1. `$ bundle exec rake db:migrate RACK_ENV=test`


### Release 1: Associations (30 - 45 minutes)
We will be working with four models: `Auction`, `Bid`, `Item`, and `User`.  Create the associations between the models based on the following descriptions.  In addition, tests have been written for the associations of each model.  The tests for associations have been placed in an example group named *model associations*.

The models and method calls are listed alphabetically; you might need to write them in a different order.

**Auction**
- `auction.bidders` returns the users who have bid in the auction.
- `auction.bids` returns the bids placed for the auction.
- `auction.item` returns the item listed in the auction.
- `auction.lister` returns the user who created the auction


**Bid**
- `bid.auction` returns the auction in which the bid was placed.
- `bid.bidder` returns the user who placed the bid.
- `bid.item` returns the item on which the bid was placed.
- `bid.receiver` returns the user who listed the item on which the bid was placed.

**Item**
- `item.auction` returns the auction in which the item is listed.
- `item.lister` returns the user who listed the item

**User**
- `user.auctions` returns the auctions created by the user.
- `user.bids` returns the bids the user has placed
- `user.bid_on_items` returns the items on which the user has bid.
- `user.listed_items` returns the items the user has listed.

### Release 2: Additional Model Behaviors (20 - 30 minutes)
Once the associations have been written, let's add some additional behaviors to our models.  Some of the behaviors will be for the class itself (e.g., `Auction`) while others will be for instances (e.g., `auction`).  Tests have been written for the behaviors of each model.  The tests for these behaviors have been placed in an example group named *additional model behaviors*.

The models and method calls are listed alphabetically; it might be easier to write them in a different order.

**Auction Class**
- `Auction.completed` returns all the auctions that have ended.
- `Auction.live` returns all the auctions currently running.
- `Auction.scheduled` returns all the auctions that have yet to begin.

**Auction Instances**
- `auction.highest_bid` returns the bid with the highest amount for the auction.
- `auction.highest_bidder` returns the user who placed the highest bid for the auction.

**Bid Class**
- `Bid.highest` returns the bid with the highest amount.
- `Bid.highest_bidder` returns the user who placed the highest bid.

**User Instances**
- `user.completed_auctions` returns the auctions created by the user that have ended.
- `user.live_auctions` returns the auctions created by the user that are currently running.
- `user.scheduled_auctions` returns the auctions created by the user that have yet to begin.

### Release 3: Model Validations (25 - 30 minutes)
We want to validate our models before attempting to write to the database.  Add validations to the models, according to the following descriptions.  Tests have been written for the behaviors of each model.  The tests for these validations have been placed in an example group named *validations*.

**Auction**
- An auction's item must exist.
- An auction's lister must exist.
- An auction must have a start date and time.
- An auction must have an end date and time.
- An auction's end date and time must be later than it's start date and time.

**Bid**
- A bid's auction must exist.
- A bid's bidder must exist.
- A bid must have an amount.
- A user can have only one bid per auction.
- A user cannot bid in an auction they created.

**Item**
- An item must have a title.
- An item must have a description.
- An item must have a condition.
- An item's condition must be *new*, *like new*, *good*, or *poor*.

**User**
- A user must have a username.
- A user must have a unique username.
- A user must choose a password that is at least eight characters long when creating an account.


### Release 4: User Authentication (20 - 30 minutes)
We'll begin building the interface for our application by creating views around user sign up, sign in, and sign out.

**Sign up**
- Users can create a new account for our site.
  - If sign up is successful, the user is taken to their profile page.
  - If sign up fails, the user is taken back to the sign up page and given information about what went wrong.

**Sign in**
- Users with accounts can sign into their accounts.
  - If sign in is successful, the user is taken to their profile page.
  - If sign in fails, the user is taken back to the sign in page and given information about what went wrong.

**Sign out**
- After signing in, users can sign out.

### Release 5: CRUD Auctions and Items (45 - 60 minutes)
Now we'll add some CRUD functionality around auctions and their items.  Users create auctions to sell items.  There's no reason to create an item without an auction.  But, remember the validation that an auction's item must exist.

**Auctions**
- Users can create auctions.
- Users can edit auctions.
- Users can delete auctions.

**Items**
- Users can create items.
- Users can edit items.

### Release 6:  Auction Pages and Layout (30 -45 minutes)
Let's add some pages for viewing auctions.  We'll make a page to display a single auction and a page where all the auctions are listed.  While we're at it, let's do some work on the general layout of our site.

**Individual Auctions and Layout**
- Create a page showing an individual auction.  The page should look similar to the [mockup](mockup-auction.png).


**All Auctions**
- Create a page showing a list of all live auctions.


### Release 7: CRUD Bids (30 - 45 minutes)
Let's add the functionality to allow signed-in users to bid on items.

We'll modify the individual auction view page to support bidding.  If the user is not logged in, the view should remain as is.

If a user is signed in ...
  - If the user has not already bid in the auction, display a form for creating a new bid (see [mockup](mockup-auction-with-new-bid-form.png)).
  - If the user has already bid in the auction, display the value of the bid, a form for editing the bid, and a form for deleting the bid (see [mockup](mockup-auction-with-edit-and-delete-forms.png)).

### Release 8:  Profile Page (20 - 30 minutes)
We'll now develop the view for the user profile page.  On the profile page, the user should see the auctions that they've listed:  completed, live, and scheduled auctions.  They should also see the items on which they've bid: completed and live.  Follow the [mockup](mockup-profile-page.png).

## Conclusion
Part-3 wraps up the assessment.  If you haven't already done so, commit your changes.  Please wait until the end of the assessment period to submit your solution.
