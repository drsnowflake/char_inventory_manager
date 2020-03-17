require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('../models/character')
require_relative('../models/inventory')
also_reload('../models/*')

get '/inventory/:id' do
  @characters = Character.all
  @inventory = Inventory.find_by_id(params[:id])
  erb :'inventory/edit'
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
    erb :'inventory/update'
end
