require 'sinatra'
require 'sinatra/reloader' if development?

class App < Sinatra::Base
  register Sinatra::Reloader if development?

  set :server, :puma

  get '/' do
    'Hello world!'
  end
end
