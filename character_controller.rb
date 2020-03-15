require('sinatra')
require('sinatra/contrib/all') if development?
require('pry-byebug')

require_relative('./models/character')
require_relative('./models/inventory')
require_relative('./models/item')
require_relative('./models/race')
require_relative('./models/role')
require_relative('./models/slot')
also_reload('./models/*')

# MAIN INDEX
get '/' do
  @characters = Character.all
  @items = Item.all
  @races = Race.all
  @roles = Role.all
  erb(:index)
end

# CHARACTER ROUTES

get '/character' do
  @characters = Character.all
  erb(:character_index)
end

get '/character/new' do
  @races = Race.all
  @roles = Role.all
  erb(:character_new)
end

get '/character/:id/delete' do
  @character = Character.find_by_id(params[:id])
  erb(:character_delete)
end

get '/character/:id/edit' do
  @races = Race.all
  @roles = Role.all
  @character = Character.find_by_id(params[:id])
  erb(:character_edit)
end

get '/character/:id' do
  @character = Character.find_by_id(params[:id])
  @inventory = Inventory.find_inventory(params[:id])
  erb(:character_show)
end

post '/character' do
  @character = Character.new(params)
  @character.save()
  erb(:character_create)
end

post '/character/:id/delete' do
  @character = Character.find_by_id(params[:id])
  @inventory = Inventory.find_inventory(params[:id])
  @inventory.each do |inv|
    drop_item = Inventory.new({
      'id' => inv['inv_id'].to_i,
      'char_id' => -1,
      'item_id' => inv['id'].to_i
    })
    drop_item.update
  end
  Character.delete_by_id(params[:id])
  erb(:character_deleted)
end

post '/character/:id' do
  @character = Character.new(params)
  @character.update()
  erb(:character_update)
end

# ITEM ROUTES

get '/item' do
  @items = Item.all
  erb(:item_index)
end

get '/item/new' do
  @slots = Slot.all
  erb(:item_new)
end

get '/item/:id/delete' do
  @item = Item.find_by_id(params[:id])
  erb(:item_delete)
end

get '/item/:id/edit' do
  @slots = Slot.all
  @item = Item.find_by_id(params[:id])
  erb(:item_edit)
end

get '/item/:id' do
  @item = Item.find_by_id(params[:id])
  erb(:item_show)
end

post '/item' do
  @item = Item.new(params)
  @item.save
  @inventory = Inventory.new({
    'char_id' => -1,
    'item_id' => @item.id
    })
  @inventory.save
  erb(:item_create)
end

post '/item/:id/delete' do
  @item = Item.find_by_id(params[:id])
  Inventory.delete_by_id(@item['inv_id'])
  Item.delete_by_id(params[:id])
  erb(:item_deleted)
end

post '/item/:id' do
  @item = Item.new(params)
  @item.update
  erb(:item_update)
end

# INVENTORY ROUTES

get '/inventory/:id' do
  @characters = Character.all
  @inventory = Inventory.find_by_id(params[:id])
  erb(:inventory_edit)
end

post '/inventory/:id' do
  p current_inventory = Inventory.find_inventory(params[:char_id]).map{|inv|inv}.length
  if current_inventory >= 10
    @added = false
    @inventory = Inventory.find_by_id(params[:id])
  else
    @inventory = Inventory.new({
      'id' => params[:id],
      'char_id' => params[:char_id],
      'item_id' => params[:item_id]
      })
    @inventory.update
    @inventory = Inventory.find_by_id(params[:id])
    @added = true
  end
    erb(:inventory_update)
end

# RACE ROUTES

get '/race' do
  @races = Race.all
  erb(:race_index)
end

get '/race/new' do
  erb(:race_new)
end

get '/race/:id/delete' do
  @race = Race.new(Race.find_by_id(params[:id]))
  erb(:race_delete)
end

get '/race/:id/edit' do
  @race = Race.find_by_id(params[:id])
  erb(:race_edit)
end

post '/race' do
  @race = Race.new(params)
  @race.save
  erb(:race_create)
end

post '/race/:id/delete' do
  @races = Race.all.length
  @race = Race.new(Race.find_by_id(params[:id]))
  @chars = Race.find_chars(params[:id])
  if @races == 1
    @deleted = false
  else
    race_choice = Race.find_other_races(params[:id])
    @chars.each{|char|
      char.race_id = race_choice.sample['id'].to_i
      char.update
    }
    Race.delete_by_id(@race.id)
    @deleted = true
  end
  erb(:race_deleted)
end

post '/race/:id' do
  @race = Race.new(params)
  @race.update
  erb(:race_update)
end

# Role ROUTES

get '/role' do
  @roles = Role.all
  erb(:role_index)
end

get '/role/new' do
  erb(:role_new)
end

get '/role/:id/delete' do
  @role = Role.new(Role.find_by_id(params[:id]))
  erb(:role_delete)
end

post '/role' do
  @role = Role.new(params)
  @role.save
  erb(:role_create)
end

get '/role/:id/edit' do
  @role = Role.find_by_id(params[:id])
  erb(:role_edit)
end

post '/role/:id/delete' do
  @roles = Role.all.length
  @role = Role.new(Role.find_by_id(params[:id]))
  @chars = Role.find_chars(params[:id])
  if @roles == 1
    @deleted = false
  else
    role_choice = Role.find_other_roles(params[:id])
    @chars.each{|char|
      char.role_id = role_choice.sample['id'].to_i
      char.update
    }
    Role.delete_by_id(@role.id)
    @deleted = true
  end
  erb(:role_deleted)
end

post '/role/:id' do
  @role = Role.new(params)
  @role.update
  erb(:role_update)
end
