require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('../models/character')
also_reload('../models/*')

get '/generator' do
    erb :'generator/index'
end

post '/generator' do
    
    race_choices = Race.find_other_races(-1)
    role_choices = Role.find_other_roles(-1)
    params[:req_chars].to_i.times{
        Character.new({
            'char_name' => Character.random_name,
            'race_id' => race_choices.sample['id'].to_i,
            'role_id' => role_choices.sample['id'].to_i
        }).save
    }
    redirect :'/'
end