require 'pathname'
require 'digest/sha1'
require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra/base'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-migrations'
require 'json'
require 'erubis'

module PostBin
  def self.current_path
    Pathname.new(File.expand_path(File.dirname(__FILE__)))
  end
  
  DataMapper.setup(:default, 'postgres://ryan@localhost/postbin')
  
  Dir[PostBin.current_path + "models/*.rb"].each { |f| require f }
  
  DataMapper.finalize if DataMapper.respond_to?(:finalize)
  DataMapper.auto_upgrade!
  
  class App < Sinatra::Base
    configure do
      set :logging, Proc.new { !test? }
      set :static, true
    end
    
    get '/' do
      erb :index
    end
    
    get '/bins' do
      erb :index
    end
    
    get '/about' do
      erb :about
    end
    
    get '/love' do
      erb :love
    end
    
    post '/bins' do
      bin = Bin.new
      # TOOD: Figure out why a before :create callback won't work in the Bin model
      # Fucking Datamapper, man.
      url = bin.random_url
      # Pick another if it already exists, keep trying
      until Bin.first(:url => url).nil?
        url = bin.random_url
      end
      bin.url = url
      bin.save!
      redirect bin.url
    end

    get '/:id' do
      @bin = Bin.first(:url => params[:id])
      erb :show
    end

    post '/:bin_id' do
      @bin = Bin.first(:url => params[:bin_id])
      params.delete("bin_id")
      @bin.items.create(:params => params.to_json)

      "OK"
    end

    def json(v)
      JSON.parse(v).to_json(JSON::State.new(:object_nl => "<br>", :indent => "&nbsp;&nbsp;", :space => "&nbsp;"))
    end
      
  end
end
