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

get '/item/:id' do
  @item = Item.find_by_id(params[:id])
  erb(:item_show)
end

post '/item' do
  @item = Item.new(params)
  @item.save()
  @inventory = Inventory.new({
    'char_id' => -1,
    'item_id' => @item.id
    })
  @inventory.save
  erb(:item_create)
end
