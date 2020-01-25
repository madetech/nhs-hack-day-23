require 'sinatra'
require 'rack-livereload'
require 'zeitwerk'

$loader = Zeitwerk::Loader.new
$loader.push_dir("#{__dir__}/lib/")
$loader.enable_reloading

use Rack::LiveReload

$: << "#{__dir__}/lib/"

require 'routes'

