require 'sinatra'
require 'rack-livereload'
require 'sinatra/reloader'
require 'sinatra/cookies'

require_relative './loader'

use Rack::LiveReload

require 'routes'

