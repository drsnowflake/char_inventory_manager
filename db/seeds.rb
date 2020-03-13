require_relative('../models/inventory')
require_relative('../models/character')
require_relative('../models/item')

Inventory.delete_all
Character.delete_all
Item.delete_all

character1 = Character.new({
  'name' => 'Dave Shadowbreaker',
  'race' => 'Dwarf',
  'class' => 'Paladin'
  })

character2 = Character.new({
  'name' => 'Justice Lightfoot',
  'race' => 'Half-Elf',
  'class' => 'Druid'
  })

character3 = Character.new({
  'name' => 'Bobby DropTable',
  'race' => 'Troll',
  'class' => 'Rogue'
  })

character4 = Character.new({
  'name' => 'Zugg Zugg',
  'race' => 'Half-Orc',
  'class' => 'Barbarian'
  })

character1.save
character2.save
character3.save
character4.save

item1 = Item.new({
  'name' => 'test_helmet_1',
  'slot' => 1,
  'flav' => 'helm1 -- This is some random fluff about the item, its nifty'
  })

item2 = Item.new({
  'name' => 'test_helmet_2',
  'slot' => 1,
  'flav' => 'helm2 -- This is some random fluff about the item, its not so nifty'
  })

item3 = Item.new({
  'name' => 'test_helmet_3',
  'slot' => 1,
  'flav' => 'helm3 -- This is some random fluff about the item, its pretty trash'
  })

item1.save
item2.save
item3.save

inventory1 = Inventory.new({
  'char_id' => character1.id,
  'item_id' => item1.id
  })

inventory2 = Inventory.new({
  'char_id' => character2.id,
  'item_id' => item2.id
  })

inventory1.save
inventory2.save


p character1
p item1
p inventory
