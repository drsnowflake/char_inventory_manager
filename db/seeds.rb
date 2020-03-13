require_relative('../models/inventory')
require_relative('../models/character')
require_relative('../models/role')
require_relative('../models/item')
require_relative('../models/race')
require_relative('../models/slot')

Inventory.delete_all
Character.delete_all
Item.delete_all
Role.delete_all
Race.delete_all
Slot.delete_all

slot1 = Slot.new({
  'slot_name' => 'Head'
  })

slot2 = Slot.new({
  'slot_name' => 'Chest'
  })

slot3 = Slot.new({
  'slot_name' => 'Hands'
  })

slot4 = Slot.new({
  'slot_name' => 'Legs'
  })

slot5 = Slot.new({
  'slot_name' => 'Feet'
  })

slot6 = Slot.new({
  'slot_name' => 'Weapon'
  })

slot1.save
slot2.save
slot3.save
slot4.save
slot5.save
slot6.save

role1 = Role.new({
  'role' => 'Paladin'
  })

role2 = Role.new({
  'role' => 'Druid'
  })

role3 = Role.new({
  'role' => 'Rogue'
  })

role4 = Role.new({
  'role' => 'Barbarian'
  })

role1.save
role2.save
role3.save
role4.save

race1 = Race.new({
  'race' => 'Dwarf'
  })

race2 = Race.new({
  'race' => 'Half-Elf'
  })

race3 = Race.new({
  'race' => 'Troll'
  })

race4 = Race.new({
  'race' => 'Orc'
  })

race1.save
race2.save
race3.save
race4.save

character1 = Character.new({
  'char_name' => 'Dave Shadowbreaker',
  'race_id' => race1.id,
  'role_id' => role1.id
  })

character2 = Character.new({
  'char_name' => 'Justice Lightfoot',
  'race_id' => race2.id,
  'role_id' => role2.id
  })

character3 = Character.new({
  'char_name' => 'Bobby DropTable',
  'race_id' => race3.id,
  'role_id' => role3.id
  })

character4 = Character.new({
  'char_name' => 'Zugg Zugg',
  'race_id' => race4.id,
  'role_id' => role4.id
  })

character1.save
character2.save
character3.save
character4.save

item1 = Item.new({
  'item_name' => 'test_helmet_1',
  'slot' => slot1.id,
  'flav' => 'helm1 -- This is some random fluff about the item, its nifty'
  })

item2 = Item.new({
  'item_name' => 'test_helmet_2',
  'slot' => slot1.id,
  'flav' => 'helm2 -- This is some random fluff about the item, its not so nifty'
  })

item3 = Item.new({
  'item_name' => 'test_helmet_3',
  'slot' => slot1.id,
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

inventory3 = Inventory.new({
  'char_id' => -1,
  'item_id' => item3.id
  })

inventory1.save
inventory2.save
inventory3.save

p character1
p item1
p inventory1
