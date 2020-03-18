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
  current_inventory = Inventory.find_inventory(params[:char_id]).map{|inv|inv}.length
  if params[:char_id].to_i >= 0 && current_inventory >= Inventory.capacity
    @inventory = Inventory.find_by_id(params[:id])
    redirect :"item/#{params[:item_id]}?moved=false"
  else
    @inventory = Inventory.new({
      'id' => params[:id],
      'char_id' => params[:char_id],
      'item_id' => params[:item_id],
      'equipped' => false
      })
    @inventory.update
    @inventory = Inventory.find_by_id(params[:id])
    redirect :"item/#{params[:item_id]}"
  end
end
