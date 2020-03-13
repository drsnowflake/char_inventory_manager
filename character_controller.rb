require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('models/character')
require_relative('models/item')
also_reload('./models/*')
