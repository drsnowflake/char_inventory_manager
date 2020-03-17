require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('../models/inventory')
require_relative('../models/item')
require_relative('../models/slot')
also_reload('../models/*')

get '/item' do
  @items = Item.all
  erb :'item/index'
end

get '/item/new' do
  @slots = Slot.all
  erb :'item/new'
end

get '/item/:id/delete' do
  @item = Item.find_by_id(params[:id])
  erb :'item/delete'
end

get '/item/:id/edit' do
  @slots = Slot.all
  @item = Item.find_by_id(params[:id])
  erb :'item/edit'
end

get '/item/:id' do
  @item = Item.find_by_id(params[:id])
  erb :'item/show'
end

post '/item' do
  @item = Item.new(params)
  @item.save
  @inventory = Inventory.new({
    'char_id' => -1,
    'item_id' => @item.id
    })
  @inventory.save
  erb :'item/create'
end

post '/item/:id/delete' do
  @item = Item.find_by_id(params[:id])
  Inventory.delete_by_id(@item['inv_id'])
  Item.delete_by_id(params[:id])
  query = @item.map{|key, value| "#{key}=#{value}"}.join("&")
  redirect :"/item?#{query}"
end

post '/item/:id' do
  @item = Item.new(params)
  @item.update
  erb :'item/update'
end
