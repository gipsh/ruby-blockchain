require 'sinatra'
require 'sinatra/json'
require 'sinatra/base'
#require 'thin'
require 'oj'
require 'json'
require_relative './blockchain.rb'

set :bind, '0.0.0.0'

@nodes = []

bc = Blockchain.new
bc.create_block('hi im the first block')
bc.create_block('hi im the second block')


get '/chain' do
 b = Oj.dump(bc)
 JSON.pretty_generate(JSON.parse(b))
end

post '/node/register' do
end

get '/node/nodes' do
	@nodes.to_json
end
