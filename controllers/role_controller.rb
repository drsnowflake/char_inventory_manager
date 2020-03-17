require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('../models/role')
also_reload('../models/*')

get '/role' do
  @roles = Role.all
  erb :'role/index'
end

get '/role/new' do
  erb :'role/new'
end

get '/role/:id/delete' do
  @role = Role.new(Role.find_by_id(params[:id]))
  erb :'role/delete'
end

post '/role' do
  @role = Role.new(params)
  @role.save
  erb :'role/create'
end

get '/role/:id/edit' do
  @role = Role.find_by_id(params[:id])
  erb :'role/edit'
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
  erb :'role/deleted'
end

post '/role/:id' do
  @role = Role.new(params)
  @role.update
  erb :'role/update'
end
