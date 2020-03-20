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
    requested = params[:req_chars].to_i
    
    dupe_counter = 0
    counter = 0
    until counter == requested
        generated_name = Character.random_name.chomp
        until Character.find_by_name(generated_name).nil?
            generated_name = Character.random_name
            dupe_counter += 1
        end
        Character.new({
            'char_name' => generated_name,
            'race_id' => race_choices.sample['id'].to_i,
            'role_id' => role_choices.sample['id'].to_i
        }).save
        counter += 1
    end
    p "Difference was #{counter - dupe_counter}"
    redirect :'/'
end