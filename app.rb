require 'sinatra'
require 'rack-livereload'
require 'zeitwerk'
require 'sinatra/reloader'

$loader = Zeitwerk::Loader.new
$loader.push_dir("#{__dir__}/lib/")
$loader.enable_reloading

use Rack::LiveReload

$: << "#{__dir__}/lib/"

require 'routes'

