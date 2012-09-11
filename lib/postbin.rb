require 'pathname'
require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra/base'

module PostBin
  class App < Sinatra::Base
    configure do
      set :logging, Proc.new { !test? }
      set :static, true
    end

    get '/' do
      redirect 'http://postbin.ryanbigg.com', 301
    end

    get '/bins' do
      redirect 'http://postbin.ryanbigg.com/bins', 301
      erb :index
    end

    get '/about' do
      redirect 'http://postbin.ryanbigg.com/about', 301
      erb :about
    end

    get '/love' do
      redirect 'http://postbin.ryanbigg.com/love', 301
      erb :love
    end

    get '/:id' do
      redirect "http://postbin.ryanbigg.com/#{params[:id]}", 301
    end

    post '/:bin_id' do
      status 403
%Q{Heroku has imposed a database limit of 10,000 rows. Please use http://postbin.ryanbigg.com now.

Postbin has slightly more (try adding a couple of zeroes) than 10,000 rows.\n}
    end
  end
end
