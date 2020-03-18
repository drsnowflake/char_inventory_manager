require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('../models/character')
require_relative('../models/inventory')
require_relative('../models/race')
require_relative('../models/role')
also_reload('../models/*')

get '/character' do
  @characters = Character.all
  erb :'character/index'
end

get '/character/new' do
  @races = Race.all
  @roles = Role.all
  erb :'character/new'
end

get '/character/:id/delete' do
  @character = Character.find_by_id(params[:id])
  erb :'character/delete'
end

get '/character/:id/edit' do
  @races = Race.all
  @roles = Role.all
  @character = Character.find_by_id(params[:id])
  erb :'character/edit'
end

get '/character/:id' do
  @character = Character.find_by_id(params[:id])
  @inventory = Inventory.find_inventory(params[:id])
  erb :'character/show'
end

post '/character' do
  @character = Character.new(params)
  @character.save()
  redirect :'character'
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
  params = "char_name=#{@character['char_name']}"
  redirect :"character?#{params}"
end

post '/character/:id' do
  @character = Character.new(params)
  @character.update()
  redirect :"character/#{params[:id]}"
end
