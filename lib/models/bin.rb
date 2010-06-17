class Bin
  include DataMapper::Resource
  property :id, Serial
  property :url, String
  
  has n, :items
end