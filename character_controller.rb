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
  p params
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
  @inventory = Inventory.new({
    'id' => params[:id],
    'char_id' => params[:char_id],
    'item_id' => params[:item_id]
    })
  @inventory.update
  @inventory = Inventory.find_by_id(params[:id])
  erb(:inventory_update)
end
