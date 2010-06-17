require 'pathname'
require 'rubygems'
require 'sinatra/base'
require 'datamapper'
require 'dm-migrations'
require 'json'

module PostBin
  def self.current_path
    Pathname.new(File.expand_path(File.dirname(__FILE__)))
  end
  
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:///#{PostBin.current_path + 'my.db'}")  
  
  Dir[PostBin.current_path + "models/*.rb"].each { |f| require f }
  
  DataMapper.finalize if DataMapper.respond_to?(:finalize)
  DataMapper.auto_upgrade!
  
  class App < Sinatra::Base
    configure do
      set :raise_errors, Proc.new { test? }
      set :show_exceptions, Proc.new { development? }
      set :dump_errors, true
      set :logging, Proc.new { !test? }
      set :static, true
      set :public, "#{PostBin.current_path}/../public"
    end
    
    get '/' do
      erb :index
    end
    
    get '/about' do
      erb :about
    end
    
    post '/bins' do
      bin = Bin.create!
      bin.url = bin.id.to_s(36)
      bin.save
      redirect bin.id.to_s(36)
    end
    
    get %r{/(\w+)} do
      @bin = Bin.first(:url => params[:captures].first)
      erb :show
    end
    
    post %r{/(\w+)} do
      @bin = Bin.first(:url => params[:captures].first)
      params.delete("url")
      @bin.items.create(:params => params.to_json)

      "OK"
    end
    
    def json(v)
      JSON.parse(v).to_json(JSON::State.new(:object_nl => "<br>", :indent => "&nbsp;&nbsp;", :space => "&nbsp;"))
    end
      
  end
end