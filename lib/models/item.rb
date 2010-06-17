class Item
  include DataMapper::Resource
  property :id, Serial
  property :params, Text
  
  belongs_to :bin
  
  def parsed_params
    JSON.parse(params)
  end
  
end