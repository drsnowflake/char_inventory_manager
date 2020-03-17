require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('../models/race')
also_reload('../models/*')

get '/race' do
  @races = Race.all
  erb :'race/index'
end

get '/race/new' do
  erb :'race/new'
end

get '/race/:id/delete' do
  @race = Race.new(Race.find_by_id(params[:id]))
  erb :'race/delete'
end

get '/race/:id/edit' do
  @race = Race.find_by_id(params[:id])
  erb :'race/edit'
end

post '/race' do
  @race = Race.new(params)
  @race.save
  redirect :'race'
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
  @races = Race.all
  erb :'race/deleted'
end

post '/race/:id' do
  @race = Race.new(params)
  @race.update
  redirect :'race'
end
