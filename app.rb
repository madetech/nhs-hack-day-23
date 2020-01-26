require 'sinatra'
require 'rack-livereload'
require 'sinatra/reloader'
require 'raven'
require 'sinatra/cookies'

require_relative './loader'

use Rack::LiveReload
use Raven::Rack

require 'routes'

