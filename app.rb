require 'sinatra'
require 'rack-livereload'
require 'sinatra/reloader'

require_relative './loader'

use Rack::LiveReload

require 'routes'

