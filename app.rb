require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  "Welcome to Knittable<br><br><form action='/pattern' method='post'><textarea name='csv'></textarea><br><input type='submit'/></form>" 
end

post '/pattern' do
  	"Hello #{params[:csv]}!"
end