require 'sinatra'
require 'rack-livereload'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/lib/")
loader.enable_reloading

use Rack::LiveReload

before do
  loader.reload
end

get '/' do
  recommendations = UseCase::ViewRecommendations.new.execute
  erb :index, locals: recommendations
end
