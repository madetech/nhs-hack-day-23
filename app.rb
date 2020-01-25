require 'sinatra'
require 'rack-livereload'

use Rack::LiveReload

get '/' do
  erb :index
end
