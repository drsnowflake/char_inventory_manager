### Character Inventory Manager

A Dungeon Master (DM) has approached asking for a way to monitor and modify their players inventory due to constantly losing the paper character sheets.

#### MVP

-	The app should allow the user to create new characters
-	The app should allow the user to create new items
- 	The app should allow the user to assign/remove items from characters
-	The app should allow the user to edit and delete characters/items

#### Completed Extensions

-	The app could allow the ability to add further races and classes for creation
-	The user could not be able to assign more than 10 items to a character
-	The app could not only have a page showing all characters/items but also the ability to see items equipped to a particular character

#### In Progress Extensions

-	Each instance of a character could have a designated wearable inventory
-	The app could restrict certain items (eg helmets/gloves) to specific slots (eg head/hands) in the character inventory
-	Tracking of character health/stats

#### Usage Instructions

Once cloned the following commands should be ran in order from the root directroy of the cloned folder "project_1"

```createdb inventory_manager```

```psql -d inventory_manager -f db/inventory_manager.sql```

```ruby app.rb```

Once the app is active you can navigate to localhost:4567 in your browser of choice and add either /reseed or /demo to populate the database and with demo data to test out the app