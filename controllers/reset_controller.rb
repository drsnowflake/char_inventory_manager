require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('../controllers/character_controller')
require_relative('../controllers/inventory_controller')
require_relative('../controllers/item_controller')
require_relative('../controllers/race_controller')
require_relative('../controllers/role_controller')
require_relative('../models/character')
require_relative('../models/item')
require_relative('../models/race')
require_relative('../models/role')
also_reload('./models/*')


get '/reset-mini' do
  erb :'resets/reset-mini'
end

get '/reset' do
  erb :'resets/reset'
end

