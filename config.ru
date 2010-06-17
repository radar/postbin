$:.unshift File.expand_path("#{File.dirname(__FILE__)}/lib")

require "postbin"

map '/' do
  run PostBin::App
end
