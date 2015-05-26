# Part 3: Build a CRUD App

## Summary
In Part 3 of the assessment, we'll demonstrate our proficiency in building Sinatra applications: user authentication, associations, validations, controllers, views, etc. Even a little bit of CSS.

### Site Overview
We'll be building a simplified version of a blind auction site—in a blind auction, bidders do not see how much other bidders have bid.

The required functionality of the site will be described in more detail in the *Releases* section, but here's a basic overview.

**All Users**
- Browse available items.

**Unregistered Users**
- Register a new account.

**Registered Users**
- Sign in and out.
- List new items.
- Place bids on items.
- Have a profile showing their listing and bidding activity.

### Completing the App
Complete as much of this CRUD app as possible in the time allowed.  If time is running out and it looks like the app will not be completed, continue to work through the releases in order and complete as much as possible. Be sure to ask questions, if you find yourself stuck.

## Releases
### Pre-release:  Setup
We'll need to make sure that everything is set up before we begin working on the application.  From the command line, navigate to the `part-3` directory of the phase 2 assessment.  Once there, run ...

0. `$ bundle`
0. `$ bundle exec rake db:create`

### Release 0: User Registration
Users will need to register for a new account. Create a link on the home page that will take them to a page where they can enter their desired username and password. There are a two constraints to this feature:

1. The username must be unique
1. The password must be at least 6 characters long

If both constraints are met, the user should be considered logged in and redirected to the home page where all references to "Register" removed.

If either constraint is not met, the user should see the registration form and the associated error messages.

### Release 1: Login/Logout
#### Login
Given there is a previously registered user and they are not currently logged in:

On the home page, create a link to login.
When a user clicks on this link they should be taken to a page with a form to enter their credentials.

If the credentials match, the user should be taken back to the homepage and the login link should be replaced with a logout link.

If the credentials do not match, the user should see the login form and an error message stating the credentials were not valid.

#### Logout
Given there is a previously registered user and they are currently logged in:

On the home page create a link to logout.
When the user clicks on the logout link they should be taken to the home page and the links "Register" and "Login" should both be visible.

### Release 2: CRUD'ing a Resorouce
The users profile page is where users are able to manage their listed items. We'll start off by giving them the ability to add an item and then work through the remaining CRUD actions.

#### Creating Items
Given the registered user is signed in:

On the home page create a link to the user's profile page.
When the user clicks on the profile link they should be taken to their profile page.

Create a link on this page to add an item to the auction site. The item should include things like a name and/or title, description, when the user would like the auction to start and when it should stop.

  *Note*: When creating and or editing an item, you'll need to create forms that allow you to enter dates. The HTML5 datetime input type is tricky to use with ActiveRecord. Consider using something like `<input type="text" name="my-date">` in the markup. When filling in the field, use the `YYYY-MM-DD` or `YYYY-MM-DD HH:MM:SS` format (e.g. 2015-04-01 14:30:00).

After submitting an item the user should be back on their profile page.

#### Reading Items
Given the registered user is signed in and has previously created multiple items.

Create a section on the profile page to display all the items. This section should not include the long form description of the item.

#### Updating Items
Given the registered user is signed in and has previously created multiple items.

On the profile page, create an edit link associated to each of the items the user has created. This link should only be visible if the user logged in is the user that created the item.

When the user clicks the edit link associated to the item, they should be taken to a page to edit that item's details. After submitting this information the user should be taken back to their profile page and see the item's updates should be reflected on the page.

#### Deleting Items
Given the registered user is signed in and has previously created multiple items.

On the profile page, create a delete link associated to each of the items the user has created. Just like in the update section, this link should only be visible if the user logged in is the user that created the item.

When the user clicks the delete link, the user profile page should reload and the item should no longer be visible.

### Release 3: Bidding






================Ignore below this line=========================

### Release 1: Associations
We will be working with four models: `Auction`, `Bid`, `Item`, and `User`.  Create the associations between the models based on the following descriptions.  It might be beneficial to create a visual representation of the database schema, based on the migrations.

**Bid**
- `bid.auction` returns the auction in which the bid was placed.
- `bid.bidder` returns the user who placed the bid.

To tests these associations, from the root directory run:
```
rspec --tag bid_associations
```

**Auction**
- `auction.bids` returns the bids placed for the auction.
- `auction.bidders` returns the users who have bid in the auction.
- `auction.item` returns the item listed in the auction.
- `auction.lister` returns the user who created the auction

To tests these associations, run:
```
rspec --tag auction_associations
```

**Item**
- `item.auction` returns the auction in which the item is listed.

To tests these associations, run:
```
rspec --tag item_associations
```

**User**
- `user.listed_auctions` returns the auctions created by the user.
- `user.bids` returns the bids the user has placed
- `user.bid_in_auctions` returns the auctions for which the user has placed a bid

To tests these associations, run:
```
rspec --tag user_associations
```

### Release 2: Additional Model Behaviors
Once the associations have been written, let's add some additional behaviors to our models.  Some of the behaviors will be for the class itself (e.g., `Auction`) while others will be for instances (e.g., `user`).

**Auction Class**
- `Auction.completed` returns all the auctions with end dates earlier than today's date.
- `Auction.live` returns all the auctions with start dates earlier than or equal to today's date and end dates later than or equal to today's date.
- `Auction.scheduled` returns all the auctions with start dates after today's date.

To tests these behaviors, run:
```
rspec --tag auction_behaviors
```

**User Instances**
- `user.completed_listed_auctions` returns the auctions created by the user that have ended.
- `user.live_listed_auctions` returns the auctions created by the user that are currently running.
- `user.scheduled_listed_auctions` returns the auctions created by the user that have yet to begin.

To tests these behaviors, run:
```
rspec --tag user_behaviors
```

### Release 3: Model Validations
We want to validate our models before attempting to write to the database.  Add validations to the models, according to the following descriptions.  

**Auction**
- An auction's item must exist.
- An auction's lister must exist.
- An auction must have a start date.
- An auction must have an end date.
- An auction's end date must be later than its start date.

To tests these validations, run:
```
rspec --tag auction_validations
```

**Bid**
- A bid's auction must exist.
- A bid's bidder must exist.
- A bid must have an amount.
- A user can have only one bid per auction.
- A user cannot bid in an auction they created.

To tests these validations, run:
```
rspec --tag bid_validations
```

**User**
- A user must have a username.
- A user must have a unique username.

To tests these validations, run:
```
rspec --tag user_validations
```

### Release 4: User Authentication
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


### Release 5: CRUD Auctions and Items
Now we'll add some CRUD functionality around auctions.  Users create auctions to sell items.  There's no reason to create an item without an auction, and remember the validation that an auction's item must exist.

**Auctions**
- Users can create auctions.
- Users can edit their own auctions.
- Users can delete their own auctions.


### Release 6:  Auction Pages and Layout
Let's add some pages for viewing auctions.  We'll make a page to display a single auction and a page where all the auctions are listed.  While we're at it, let's do some work on the general layout of our site.

**Individual Auctions and Layout**
- Create a page showing an individual auction.  The page should look similar to the [mockup](mockup-auction.png).


**All Auctions**
- Create a page showing a list of all live auctions.


### Release 7: CRUD Bids
Let's add the functionality to allow signed-in users to bid on items.

We'll modify the individual auction view page to support bidding.  If the user is not logged in, the view should remain as is.

If a user is signed in ...
  - If the user has not already bid in the auction, display a form for creating a new bid (see [mockup](mockup-auction-with-new-bid-form.png)).
  - If the user has already bid in the auction, display the value of the bid, a form for editing the bid, and a form for deleting the bid (see [mockup](mockup-auction-with-edit-and-delete-forms.png)).

### Release 8:  Profile Page
We'll now develop the view for the user profile page.  On the profile page, the user should see the auctions that they've listed:  completed, live, and scheduled auctions.  They should also see the items on which they've bid: completed and live.  Follow the [mockup](mockup-profile-page.png).

## Conclusion
Part-3 wraps up the assessment.  If you haven't already done so, commit your changes.  Please wait until the end of the assessment period to submit your solution.
